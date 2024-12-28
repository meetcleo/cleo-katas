# frozen_string_literal: true

class ChristmasDay
  require_relative 'weekday'

  class JulianWeekdayCalculator
    attr_reader :year, :month, :day
    private :year, :month, :day

    def initialize(year:, month:, day:)
      @year = year
      @month = month
      @day = day
    end

    def weekday
      day_dup = day
      if month < 3
        month_dup = month + 12
        year_dup = year - 1
      else
        month_dup = month
        year_dup = year
      end
      year_offset = year_dup + (year_dup / 4)
      month_offset = ((13 * (month_dup + 1)) / 5)
      index = (day_dup + month_offset + year_offset + 4) % 7
      Weekday.new(index).name
    end
  end
end
