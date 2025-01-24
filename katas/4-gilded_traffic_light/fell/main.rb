# frozen_string_literal: true

require 'bundler/inline'
require_relative 'traffic_light'

gemfile do
  source 'https://rubygems.org'

  gem 'minitest'
end

class TrafficLightSystem
  def initialize
    @lights = [
      TrafficLight.new(direction: "North-South", state: "red",   timer: 10),
      TrafficLight.new(direction: "East-West",   state: "green", timer: 8),
    ]
    @pedestrian_signals = {
      "North-South" => false,
      "East-West"   => false
    }
  end

  # Advances the system by one second: prints current status, decrements timers,
  # and updates states as needed, all in one giant procedural block.
  def run
    # Clear the screen each time (so this is consistent with the original request).
    # You could skip this if you don't want console clearing in tests, but it's here for completeness.
    # system("clear") || system("cls")

    # Print traffic lights
    puts @lights.map(&:to_s)

    # Update timers and transition states in one big chunk
    @lights.each do |light|
      light.progress
      if light.timer <= 0
        # Big case statement for state transitions
        case light.state
        when "red"
          # Switch from red -> green
          light.state = "green"
          light.timer = 8
          @pedestrian_signals[light.direction] = false
          # Force the opposite light red if it's green or amber
          opposite = @lights.find { |l| l.direction != light.direction }
          if %w[green amber].include?(opposite.state)
            opposite.state = "red"
            opposite.timer = 10
            @pedestrian_signals[opposite.direction] = true
          end

        when "green"
          # Switch from green -> amber
          light.state = "amber"
          light.timer = 3
          @pedestrian_signals[light.direction] = false

        when "amber"
          # Switch from amber -> red
          light.state = "red"
          light.timer = 10
          @pedestrian_signals[light.direction] = true
        end
      end
    end

    # Print pedestrian signals
    puts "\nPedestrian signals:"
    @pedestrian_signals.each do |direction, can_walk|
      signal_text = can_walk ? "\e[32mWALK\e[0m" : "\e[31mDON'T WALK\e[0m"
      puts "  #{direction}: #{signal_text}"
    end

    puts "---------------------------------"
  end
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
