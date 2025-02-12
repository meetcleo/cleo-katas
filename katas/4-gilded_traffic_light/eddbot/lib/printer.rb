class Printer
  def initialize(out: STDOUT)
    @out = out
  end

  def print_traffic_lights(lights:)
    lights.each do |light|
      puts("Direction: #{light[:direction]}, State: #{state_colour(state: light[:state])}, Time left: #{light[:timer]}s")
    end
  end

  def print_pedestrian_signals(signals:)
    puts "\nPedestrian signals:"
    signals.each do |direction, can_walk|
      signal_text = can_walk ? colourizer(:green, "WALK") : colourizer(:red, "DON'T WALK")
      puts "  #{direction}: #{signal_text}"
    end

    puts "---------------------------------"
  end

  private

  def state_colour(state:) = colourizer(state.to_sym, state)

  def colourizer(color, input)
    case color
    when :red then "\e[31m#{input}\e[0m"
    when :green then "\e[32m#{input}\e[0m"
    when :amber then "\e[33m#{input}\e[0m"
    else
      input
    end
  end

  attr_reader :out
end