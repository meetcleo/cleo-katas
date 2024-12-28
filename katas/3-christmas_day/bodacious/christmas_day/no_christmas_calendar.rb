# frozen_string_literal: true

class ChristmasDay
  require_relative 'calendar'
  require_relative 'weekday'
  require_relative 'error'

  class NoChristmasCalendar < Calendar
    class WeekdayCalculator
      attr_reader :year

      def initialize(year:, **)
        @year = year
      end

      def weekday
        raise ChristmasDay::Error, "Can't calculate weekday for year #{year}"
      end
    end

    def weekday_calculator_class
      WeekdayCalculator
    end
  end
end
