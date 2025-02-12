class Printer
  def initialize(out: STDOUT)
    @out = out
  end

  def print_traffic_lights(lights:)
    lights.each do |light|
      # Quick inline way to colour states, done in a messy way rather than a dedicated method.
      state_colour = case light[:state]
                     when "red" then "\e[31m#{light[:state]}\e[0m"
                     when "green" then "\e[32m#{light[:state]}\e[0m"
                     when "amber" then "\e[33m#{light[:state]}\e[0m"
                     else light[:state]
                     end
      puts("Direction: #{light[:direction]}, State: #{state_colour}, Time left: #{light[:timer]}s")
    end
  end

  def print_pedestrian_signals(signals:)
    puts "\nPedestrian signals:"
    signals.each do |direction, can_walk|
      signal_text = can_walk ? "\e[32mWALK\e[0m" : "\e[31mDON'T WALK\e[0m"
      puts "  #{direction}: #{signal_text}"
    end

    puts "---------------------------------"
  end

  private

  attr_reader :out
end