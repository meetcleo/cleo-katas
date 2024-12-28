# frozen_string_literal: true

class ChristmasDay
  require_relative 'weekday'

  class GregorianWeekdayCalculator
    attr_reader :year, :month, :day
    private :year, :month, :day

    def initialize(year:, month:, day:)
      @year = year
      @month = month
      @day = day
    end

    def weekday
      day_dup = day.dup
      month_dup = month.dup
      year_dup = year.dup

      day_dup += month < 3 ? year_dup -= 1 : year_dup - 2
      index = (((23 * month_dup / 9) + day_dup + 4 + (year_dup / 4) - (year_dup / 100) + (year_dup / 400))) % 7
      Weekday.new(index).name
    end
  end
end
