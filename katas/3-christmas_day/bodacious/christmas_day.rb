# frozen_string_literal: true

require_relative 'christmas_day/period'
require_relative 'christmas_day/no_christmas_calendar'
require_relative 'christmas_day/julian_calendar'
require_relative 'christmas_day/gregorian_calendar'

class ChristmasDay

  attr_reader :weekday

  # A list of the various time periods in English history
  # @!visibility private
  # @type [Array<Period>]
  PERIODS = [
    Period.new(start_year: nil, end_year: 596, calendar: NoChristmasCalendar.new),
    Period.new(start_year: 597, end_year: 1643, calendar: JulianCalendar.new),
    Period.new(start_year: 1644, end_year: 1659, calendar: NoChristmasCalendar.new),
    Period.new(start_year: 1660, end_year: 1751, calendar: JulianCalendar.new),
    Period.new(start_year: 1752, end_year: 2024, calendar: GregorianCalendar.new),
    Period.new(start_year: 2025, end_year: nil, calendar: NoChristmasCalendar.new)
  ].freeze
  private_constant :PERIODS

  DAY = 25
  private_constant :DAY

  MONTH = 12
  private_constant :MONTH

  # @param [Integer] year
  def initialize(year)
    period = PERIODS.find { |p| p.cover?(year.to_i) }
    calendar = period.calendar
    @weekday = calendar.weekday_calculator_class.new(year: year, month: MONTH, day: DAY).weekday
  end
end
