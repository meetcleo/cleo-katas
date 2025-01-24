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
      next unless light.current_state_complete?

      # Big case statement for state transitions
      case light.state
      when TrafficLight::RED_STATE
        # Switch to green
        light.green!
        # Force the opposite light red if it's green or amber
        opposite = @lights.find { |l| l.direction != light.direction }
        opposite.red! if TrafficLight::GOING_STATES.include?(opposite.state)

      when TrafficLight::GREEN_STATE
        # Switch to amber
        light.amber!
      when TrafficLight::AMBER_STATE
        # Switch to red
        light.red!
      end
    end

    # Print pedestrian signals
    puts "\nPedestrian signals:"
    puts(@lights.map { |l| "  #{l.pedestrian_signal_status}" })

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
