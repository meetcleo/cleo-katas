require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'minitest'
  gem 'byebug'
end

class ChristmasDay
  class InvalidYear < StandardError
    def initialize(year)
      super("Can't calculate weekday for year %s" % year)
    end
  end

  class Period
    attr_reader :calendar, :start_year, :end_year
    private :start_year, :end_year

    def initialize(start_year:, end_year:, calendar: GregorianCalendar.new)
      @start_year = start_year
      @end_year = end_year
      @calendar = calendar
    end

    def cover?(year)
      (start_year..end_year).cover?(year)
    end
  end

  class Calendar
    class Date
      WEEKDAYS = %w[ Sunday Monday  Tuesday Wednesday Thursday Friday Saturday ]

      attr_reader :year, :month, :day

      def initialize(year:, month:, day:, calendar:)
        @year = year
        @month = month
        @day = day
        @calendar = calendar
      end

      def weekday
        WEEKDAYS[weekday_index]
      end

      private

      def weekday_index
        fail ChristmasDay::InvalidYear.new(year)
      end
    end

    def date(year:, month:, day:)
      self.class::Date.new(calendar: self, year:, month:, day:)
    end
  end

  class GregorianCalendar < Calendar
    class Date < Date
      def weekday_index
        day_dup = day.dup
        month_dup = month.dup
        year_dup = year.dup

        day_dup += month < 3 ? year_dup -= 1 : year_dup - 2
        ((23 * month_dup / 9 + day_dup + 4 + year_dup / 4 - year_dup / 100 + year_dup / 400)) % 7
      end
    end
  end

  class JulianCalendar < Calendar
    class Date < Date
      DAYS_IN_MONTH = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

      private

      def weekday_index
        total_days = days_from_year_zero

        # Step 2: Add days from months in current year
        total_days += days_in_prior_months

        # Step 3: Add days in current month
        total_days += day

        # Step 4: Get weekday (0 = Sunday)
        # Note: Jan 1, 0001 was a Monday in the Julian calendar
        # So we add 1 to align with this historical fact
        (total_days + 5) % 7
      end

      def days_from_year_zero
        full_years = year - 1
        regular_days = full_years * 365
        leap_days = full_years / 4
        regular_days + leap_days
      end

      def days_in_prior_months
        days = 0
        (1...month).each do |m|
          days += DAYS_IN_MONTH[m]
          # Add leap day if it's February in a leap year
          if m == 2 && leap_year?
            days += 1
          end
        end
        days
      end

      def leap_year?
        # In Julian calendar, every 4th year is a leap year
        year % 4 == 0
      end
    end
  end

  class NullCalendar < Calendar
  end

  attr_reader :calendar_date
  private :calendar_date

  PERIODS = [
    Period.new(start_year: nil, end_year: 596, calendar: NullCalendar.new),
    Period.new(start_year: 597, end_year: 1643, calendar: JulianCalendar.new),
    Period.new(start_year: 1644, end_year: 1659, calendar: NullCalendar.new),
    Period.new(start_year: 1660, end_year: 1751, calendar: JulianCalendar.new),
    Period.new(start_year: 1752, end_year: 2024, calendar: GregorianCalendar.new),
    Period.new(start_year: 2025, end_year: nil, calendar: NullCalendar.new),
  ]

  DAY = 25

  MONTH = 12

  def initialize(year)
    period = PERIODS.find { |p| p.cover?(year) }
    @calendar_date = period.calendar.date(year: year, month: MONTH, day: DAY)
  end

  def weekday
    calendar_date.weekday
  end
end
