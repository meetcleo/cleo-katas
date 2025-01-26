require_relative 'pedestrian_signal'
require_relative 'traffic_light_state'

# Tracks the state, timer, and pedestrian signals,
# and provides presentation logic.
class TrafficLight
  def initialize(direction:, state:, timer:)
    @direction = direction
    # The pedestrian signals always start out not being able to allow
    # pedestrians; This isn't a good representation of the safety of the system,
    # but it's a requirement that we need to maintain.
    @pedestrian_signal = PedestrianSignal.new(can_walk: false)
    @state = TrafficLightState.new(state:, timer:)
  end

  def to_s
    "Direction: #{direction}, #{state}"
  end

  def pedestrian_signal_status
    "#{direction}: #{pedestrian_signal}"
  end

  def allows_traffic?
    state.allows_traffic?
  end

  # Unused outside of this class, but part of the public interface
  def allows_pedestrians?
    # If we've got a pedestrian_signal we should use that as we start our with
    # pedestrians being unable to walk, but otherwise we defer to the state of
    # the lights to decide.
    @pedestrian_signal&.can_walk || state.allows_pedestrians?
  end

  def progress!
    state.progress_timer
    next_state! if state.complete?
  end

  # takes lights round in red -> green -> amber -> red cycle
  def next_state!
    # Reset pedestrian signal to allow for tying pedestrian signals to lights
    # after the first cycle (where they start false)
    self.pedestrian_signal = nil

    # Progress through the cycle of states
    self.state = state.next_state
  end

  # Used by orchestrator to ensure multiple green lights at once does not
  # happen. TODO: Once we can resolve that, we shouldn't have external actors
  # setting this object's state directly.
  def red!
    # Allow pedestrians to walk, since we're stopping traffic
    self.pedestrian_signal = nil

    self.state = TrafficLightState.red
  end

  private

  def pedestrian_signal
    @pedestrian_signal ||= PedestrianSignal.new(
      can_walk: allows_pedestrians?
    )
  end

  attr_reader :direction
  attr_accessor :state
  attr_writer :pedestrian_signal
end
