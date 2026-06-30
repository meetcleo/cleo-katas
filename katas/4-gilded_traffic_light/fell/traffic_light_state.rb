require_relative 'lib/colorize'

# Handles the state of the traffic light
class TrafficLightState
  include Colorize

  RED = -'red'
  GREEN = -'green'
  AMBER = -'amber'

  DEFAULTS = {
    RED => { timer: 10 },
    GREEN => { timer: 8 },
    AMBER => { timer: 3 }
  }.freeze

  GOING_STATES = [
    GREEN,
    AMBER
  ].freeze

  class << self
    def red
      new(state: RED, **DEFAULTS[RED])
    end

    def green
      new(state: GREEN, **DEFAULTS[GREEN])
    end

    def amber
      new(state: AMBER, **DEFAULTS[AMBER])
    end
  end

  def initialize(state:, timer:)
    @state = state
    @timer = timer
  end

  def allows_traffic?
    GOING_STATES.include?(state)
  end

  def allows_pedestrians?
    # Pedestrians may only cross when it's safe to do so.
    !allows_traffic?
  end

  def complete?
    !timer.positive?
  end

  # states follow a red -> green -> amber -> red cycle
  def next_state
    case state
    when RED
      self.class.green
    when GREEN
      self.class.amber
    when AMBER
      self.class.red
    end
  end

  def progress_timer
    self.timer -= 1
  end

  def to_s
    "State: #{colorized_state}, Time left: #{timer}s"
  end

  private

  attr_accessor :state, :timer

  def colorized_state
    case state
    when RED
      red(state)
    when GREEN
      green(state)
    when AMBER
      amber(state)
    end
  end
end
