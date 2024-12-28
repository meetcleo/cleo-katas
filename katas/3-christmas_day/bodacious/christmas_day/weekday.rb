# frozen_string_literal: true

class ChristmasDay
  # Returns the day of the week for a given weekday index
  # @example
  #   Weekday.new(1).name # => "Monday"
  class Weekday
    # Days of the week in order, starting from a zero index position
    WEEKDAYS = %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday].freeze

    attr_reader :index
    private :index
    def initialize(index)
      @index = index
    end

    def name
      WEEKDAYS[index] || fail(ChristmasDay::Error, "Invalid day index #{index}")
    end
  end
end
