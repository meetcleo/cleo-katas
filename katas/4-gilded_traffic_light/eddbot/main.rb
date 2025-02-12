# frozen_string_literal: true

require 'bundler/inline'
require_relative 'lib/printer'

gemfile do
  source 'https://rubygems.org'

  gem 'minitest'
end

class TrafficLightSystem
  def initialize(out: STDOUT)
    @lights = [
      { direction: "North-South", state: "red",   timer: 10 },
      { direction: "East-West",   state: "green", timer: 8  }
    ]

    @pedestrian_signals = {
      "North-South" => false,
      "East-West"   => false
    }

    @printer = Printer.new(out:)
  end

  # Advances the system by one second: prints current status, decrements timers,
  # and updates states as needed, all in one giant procedural block.
  def run
    # Clear the screen each time (so this is consistent with the original request).
    # You could skip this if you don't want console clearing in tests, but it's here for completeness.
    system("clear") || system("cls")

    printer.print_traffic_lights(lights:)

    # Update timers and transition states in one big chunk
    lights.each do |light|
      light[:timer] -= 1
      if light[:timer] <= 0
        # Big case statement for state transitions
        case light[:state]
        when "red"
          # Switch from red -> green
          light[:state] = "green"
          light[:timer] = 8
          pedestrian_signals[light[:direction]] = false
          # Force the opposite light red if it's green or amber
          opposite = lights.find { |l| l[:direction] != light[:direction] }
          if %w[green amber].include?(opposite[:state])
            opposite[:state] = "red"
            opposite[:timer] = 10
            pedestrian_signals[opposite[:direction]] = true
          end

        when "green"
          # Switch from green -> amber
          light[:state] = "amber"
          light[:timer] = 3
          pedestrian_signals[light[:direction]] = false

        when "amber"
          # Switch from amber -> red
          light[:state] = "red"
          light[:timer] = 10
          pedestrian_signals[light[:direction]] = true

        else
          # Fallback
          light[:state] = "red"
          light[:timer] = 10
          pedestrian_signals[light[:direction]] = true
        end
      end
    end

    printer.print_pedestrian_signals(signals: pedestrian_signals)
  end
  private

  attr_reader :printer, :lights, :pedestrian_signals
end

# Only run the perpetual loop if this file is executed directly.
# Each call to #run advances the system by one second. Tests can call #run manually.
if $PROGRAM_NAME == __FILE__
  system = TrafficLightSystem.new
  loop do
    system.run
    sleep 1
  end


end
