require_relative 'pedestrian_signal'
require_relative 'lib/colorize'

class TrafficLight
  include Colorize

  def initialize(direction:, state:, timer:)
    @direction = direction
    @pedestrian_signal = PedestrianSignal.new(can_walk: false)
    @state = state
    @timer = timer
  end

  attr_reader :direction, :pedestrian_signal
  attr_accessor :state, :timer

  def to_s
    "Direction: #{direction}, State: #{colorized_state}, Time left: #{timer}s"
  end

  def pedestrian_signal_status
    "#{direction}: #{pedestrian_signal}"
  end

  def progress
    self.timer -= 1
  end

  def can_walk
    pedestrian_signal.can_walk
  end

  def can_walk=(boolean)
    pedestrian_signal.can_walk = (boolean)
  end

  private

  def colorized_state
    case state
    when 'red' then red(state)
    when 'green' then green(state)
    when 'amber' then amber(state)
    end
  end
end
