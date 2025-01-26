require_relative '../traffic_light'
require 'minitest/autorun'

class TrafficLightStateTest < Minitest::Test
  def red_test
    red = TrafficLightState.red

    assert_equal false, red.allows_traffic?
    assert_equal true, red.allows_pedestrians?
  end

  def green_test
    green = TrafficLightState.green

    assert_equal true, green.allows_traffic?
    assert_equal false, green.allows_pedestrians?
  end

  def amber_test
    amber = TrafficLightState.amber

    assert_equal true, amber.allows_traffic?
    assert_equal false, amber.allows_pedestrians?
  end

  def complete_test
    state = TrafficLightState.new(state: TrafficLightState::RED, timer: 0)

    assert_equal true, state.complete?
  end

  def incomplete_test
    state = TrafficLightState.new(state: TrafficLightState::RED, timer: 1)

    assert_equal false, state.complete?
  end

  def next_state_test
    assert_equal TrafficLightState.green, TrafficLightState.red.next_state
    assert_equal TrafficLightState.amber, TrafficLightState.green.next_state
    assert_equal TrafficLightState.red, TrafficLightState.amber.next_state
  end

  def progress_timer_test
    state = TrafficLightState.new(state: TrafficLightState::RED, timer: 1)

    assert_equal(false, timer.complete?)
    state.progress_timer
    assert_equal(true, timer.complete?)
  end

  def to_s_contains_red_state
    state = TrafficLightState.new(state: TrafficLightState::RED, timer: 1)

    assert_includes state.to_s, "State: \e[31mred\e[0m"
  end

  def to_s_contains_green_state
    state = TrafficLightState.new(state: TrafficLightState::GREEN, timer: 1)

    assert_includes state.to_s, "State: \e[32mgreen\e[0m"
  end

  def to_s_contains_amber_state
    state = TrafficLightState.new(state: TrafficLightState::AMBER, timer: 1)

    assert_includes state.to_s, "State: \e[33mamber\e[0m"
  end

  def to_s_contains_timer
    state = TrafficLightState.new(state: TrafficLightState::AMBER, timer: 1)

    assert_includes state.to_s, 'Time left: 1s'
  end
end
