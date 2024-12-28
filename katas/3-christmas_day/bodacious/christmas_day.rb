# frozen_string_literal: true

require_relative 'christmas_day/period'
require_relative 'christmas_day/no_christmas_weekday_calculator'
require_relative 'christmas_day/julian_weekday_calculator'
require_relative 'christmas_day/gregorian_weekday_calculator'

class ChristmasDay

  attr_reader :weekday

  # A list of the various time periods in English history
  # @!visibility private
  # @type [Array<Period>]
  PERIODS = [
    Period.new(start_year: nil, end_year: 596, weekday_calculator: NoChristmasWeekdayCalculator),
    Period.new(start_year: 597, end_year: 1643, weekday_calculator: JulianWeekdayCalculator),
    Period.new(start_year: 1644, end_year: 1659, weekday_calculator: NoChristmasWeekdayCalculator),
    Period.new(start_year: 1660, end_year: 1751, weekday_calculator: JulianWeekdayCalculator),
    Period.new(start_year: 1752, end_year: 2024, weekday_calculator: GregorianWeekdayCalculator),
    Period.new(start_year: 2025, end_year: nil, weekday_calculator: NoChristmasWeekdayCalculator)
  ].freeze
  private_constant :PERIODS

  DAY = 25
  private_constant :DAY

  MONTH = 12
  private_constant :MONTH

  # @param [Integer] year
  def initialize(year)
    period = PERIODS.find { |p| p.cover?(year.to_i) }
    @weekday = period.weekday_calculator.new(year: year, month: MONTH, day: DAY).weekday
  end
end
