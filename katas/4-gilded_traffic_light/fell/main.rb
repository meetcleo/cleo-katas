require_relative 'traffic_light'

# Main class providing orchestration of multiple traffic lights
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

    progress_lights

    # Print pedestrian signals
    puts "\nPedestrian signals:"
    puts(@lights.map { |l| "  #{l.pedestrian_signal_status}" })

    puts '---------------------------------'
  end

  private

  def progress_lights
    @lights.each do |light|
      light.progress!

      # TODO: This is only necessary because the timings are such that we will
      # have a clash each cycle; an ideal solution would be to change the
      # timings, but the existing output remaining the same is a requirement
      #
      # Nothing to do unless there is goign to be a conflict
      next unless @lights.all?(&:allows_traffic?)

      # Since we're turning green, then the other light must turn red
      @lights.find { it != light }.red!
    end
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
