# frozen_string_literal: true

class ChristmasDay
  require_relative 'weekday'
  require_relative 'error'

  class NoChristmasWeekdayCalculator
    attr_reader :year
    private :year

    def initialize(year:, **)
      @year = year
    end

    def weekday
      raise ChristmasDay::Error, "Can't calculate weekday for year #{year}"
    end
  end
end
