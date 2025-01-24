require_relative 'traffic_light'

class TrafficLightSystem
  def initialize
    @lights = [
      TrafficLight.new(direction: 'North-South', state: 'red', timer: 10),
      TrafficLight.new(direction: 'East-West', state: 'green', timer: 8)
    ]
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
      next unless light.timer <= 0

      # Big case statement for state transitions
      case light.state
      when 'red'
        # Switch from red -> green
        light.state = 'green'
        light.timer = 8
        light.can_walk = false
        # Force the opposite light red if it's green or amber
        opposite = @lights.find { |l| l.direction != light.direction }
        if %w[green amber].include?(opposite.state)
          opposite.state = 'red'
          opposite.timer = 10
          opposite.can_walk = true
        end

      when 'green'
        # Switch from green -> amber
        light.state = 'amber'
        light.timer = 3
        light.can_walk = false

      when 'amber'
        # Switch from amber -> red
        light.state = 'red'
        light.timer = 10
        light.can_walk = true
      end
    end

    # Print pedestrian signals
    puts "\nPedestrian signals:"
    @lights.each do |light|
      light.pedestrian_signal.to_s
      puts "  #{light.direction}: #{light.pedestrian_signal}"
    end

    puts '---------------------------------'
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
