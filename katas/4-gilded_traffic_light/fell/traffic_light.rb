require_relative 'pedestrian_signal'
require_relative 'lib/colorize'

class TrafficLight
  include Colorize

  RED_STATE = -'red'
  GREEN_STATE = -'green'
  AMBER_STATE = -'amber'

  GOING_STATES = [
    TrafficLight::GREEN_STATE,
    TrafficLight::AMBER_STATE
  ].freeze

  STATE_DEFAULTS = {
    RED_STATE => {
      timer: 10,
      can_walk: true
    },
    GREEN_STATE => {
      timer: 8,
      can_walk: false
    },
    AMBER_STATE => {
      timer: 3,
      can_walk: false
    }
  }.freeze

  def initialize(direction:, state:, timer:)
    @direction = direction
    @pedestrian_signal = PedestrianSignal.new(can_walk: false)
    @state = state
    @timer = timer
  end

  attr_reader :direction
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

  def current_state_complete?
    !timer.positive?
  end

  def red!
    self.state = RED_STATE
    self.timer = state_defaults(state: RED_STATE, key: :timer)
    self.can_walk = state_defaults(state: RED_STATE, key: :can_walk)
  end

  def green!
    self.state = GREEN_STATE
    self.timer = state_defaults(state: GREEN_STATE, key: :timer)
    self.can_walk = state_defaults(state: GREEN_STATE, key: :can_walk)
  end

  def amber!
    self.state = AMBER_STATE
    self.timer = state_defaults(state: AMBER_STATE, key: :timer)
    self.can_walk = state_defaults(state: AMBER_STATE, key: :can_walk)
  end

  private

  attr_reader :pedestrian_signal

  def state_defaults(state:, key:)
    STATE_DEFAULTS[state][key]
  end

  def colorized_state
    case state
    when RED_STATE
      red(state)
    when GREEN_STATE
      green(state)
    when AMBER_STATE
      amber(state)
    end
  end
end
