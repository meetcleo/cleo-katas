# frozen_string_literal: true

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'

  gem 'minitest'
  gem 'activesupport', '~> 7.0'
end

# An unsightly blob of procedural code that represents a working traffic light system.
#  - Only one direction can be green or amber at a time.
#  - Pedestrians can walk in a direction only when it’s red.
# traffic_light_system.rb
# Deliberately messy, procedural-style code that:
# 1) Updates traffic lights by a single second each time #run is called.
# 2) Uses inline logic for everything rather than neatly separated methods.

class TrafficLightSystem
  def initialize
    @lights = [
      { direction: "North-South", state: "red",   timer: 10 },
      { direction: "East-West",   state: "green", timer: 8  }
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
    system("clear") || system("cls")

    # Print traffic lights
    @lights.each do |light|
      # Quick inline way to colour states, done in a messy way rather than a dedicated method.
      state_colour = case light[:state]
                     when "red"   then "\e[31m#{light[:state]}\e[0m"
                     when "green" then "\e[32m#{light[:state]}\e[0m"
                     when "amber" then "\e[33m#{light[:state]}\e[0m"
                     else light[:state]
                     end

      puts "Direction: #{light[:direction]}, State: #{state_colour}, Time left: #{light[:timer]}s"
    end

    # Update timers and transition states in one big chunk
    @lights.each do |light|
      light[:timer] -= 1
      if light[:timer] <= 0
        # Big case statement for state transitions
        case light[:state]
        when "red"
          # Switch from red -> green
          light[:state] = "green"
          light[:timer] = 8
          @pedestrian_signals[light[:direction]] = false
          # Force the opposite light red if it's green or amber
          opposite = @lights.find { |l| l[:direction] != light[:direction] }
          if %w[green amber].include?(opposite[:state])
            opposite[:state] = "red"
            opposite[:timer] = 10
            @pedestrian_signals[opposite[:direction]] = true
          end

        when "green"
          # Switch from green -> amber
          light[:state] = "amber"
          light[:timer] = 3
          @pedestrian_signals[light[:direction]] = false

        when "amber"
          # Switch from amber -> red
          light[:state] = "red"
          light[:timer] = 10
          @pedestrian_signals[light[:direction]] = true

        else
          # Fallback
          light[:state] = "red"
          light[:timer] = 10
          @pedestrian_signals[light[:direction]] = true
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
