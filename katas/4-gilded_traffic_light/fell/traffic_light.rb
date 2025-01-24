class TrafficLight
  def initialize(direction:, state:, timer:)
    @direction = direction
    @state = state
    @timer = timer
  end

  def to_s
    "Direction: #{direction}, State: #{colorized_state}, Time left: #{timer}s"
  end

  def progress
    self.timer -= 1
  end

  attr_reader :direction
  attr_accessor :state, :timer

  private

  def colorized_state
    "#{color_code + state}\e[0m"
  end

  def color_code
    case state
    when 'red'   then "\e[31m"
    when 'green' then "\e[32m"
    when 'amber' then "\e[33m"
    end
  end
end
