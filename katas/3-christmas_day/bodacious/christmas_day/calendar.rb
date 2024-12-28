# frozen_string_literal: true

require_relative 'error'

class ChristmasDay
  # Represents the calendar to be used to resolve weekday for a given Christmas day
  class Calendar
    def weekday_calculator_class
      self.class.const_get('WeekdayCalculator')
    end
  end
end
