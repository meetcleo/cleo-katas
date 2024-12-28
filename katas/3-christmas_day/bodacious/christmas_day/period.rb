# frozen_string_literal: true

class ChristmasDay
  require 'forwardable'
  # Represents a period of history, with a start date to an end date. Has an associated Calendar
  # @see Range
  # @see Calendar
  class Period < DelegateClass(Range)
    attr_reader :calendar

    def initialize(start_year:, end_year:, calendar:)
      super(start_year..end_year)
      @calendar = calendar
    end
  end
end
