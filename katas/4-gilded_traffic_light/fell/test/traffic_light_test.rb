require_relative '../traffic_light'
require 'minitest/autorun'

class TrafficLightTest < Minitest::Test
  def test_direction
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: TrafficLight::GREEN_STATE)

    assert_equal 'Widdershins', light.direction
  end

  def test_state
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: TrafficLight::GREEN_STATE)

    # reader
    assert_equal TrafficLight::GREEN_STATE, light.state

    # writer
    light.state = 'test_state'
    assert_equal 'test_state', light.state
  end

  def test_timer
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: TrafficLight::GREEN_STATE)

    # reader
    assert_equal 55, light.timer

    # writer
    light.timer = 101
    assert_equal 101, light.timer
  end

  def test_direction_to_s
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: TrafficLight::GREEN_STATE)
    light.to_s

    assert_includes light.to_s, 'Direction: Widdershins'
  end

  def test_time_left_to_s
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: TrafficLight::GREEN_STATE)
    light.to_s

    assert_includes light.to_s, 'Time left: 55s'
  end

  def test_red_light_to_s
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: TrafficLight::RED_STATE)

    light.to_s

    assert_includes light.to_s, "\e[31mred\e[0m"
  end

  def test_green_light_to_s
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: TrafficLight::GREEN_STATE)

    light.to_s

    assert_includes light.to_s, "\e[32mgreen\e[0m"
  end

  def test_amber_light_to_s
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: TrafficLight::AMBER_STATE)

    light.to_s

    assert_includes light.to_s, "\e[33mamber\e[0m"
  end

  def test_progress_decrements_timer
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: TrafficLight::GREEN_STATE)
    light.progress

    assert_equal 54, light.timer
  end

  def test_cannot_walk_pedestrian_signal_status
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: TrafficLight::RED_STATE)

    light.can_walk = true

    assert_includes light.pedestrian_signal_status, "Widdershins: \e[32mWALK\e[0m"
  end

  def test_can_walk_pedestrian_signal_status
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: TrafficLight::RED_STATE)

    assert_includes light.pedestrian_signal_status, "Widdershins: \e[31mDON'T WALK\e[0m"
  end

  def test_current_state_complete
    light = TrafficLight.new(direction: 'Widdershins', timer: 0, state: TrafficLight::RED_STATE)

    assert_equal true, light.current_state_complete?
  end

  def test_current_state_incomplete
    light = TrafficLight.new(direction: 'Widdershins', timer: 1, state: TrafficLight::RED_STATE)

    assert_equal false, light.current_state_complete?
  end

  def test_red
    light = TrafficLight.new(direction: 'Widdershins', timer: 1, state: TrafficLight::GREEN_STATE)

    light.red!

    assert_equal TrafficLight::RED_STATE, light.state
    assert_equal 10, light.timer
    assert_equal true, light.can_walk
  end

  def test_green
    light = TrafficLight.new(direction: 'Widdershins', timer: 1, state: TrafficLight::RED_STATE)

    light.green!

    assert_equal TrafficLight::GREEN_STATE, light.state
    assert_equal 8, light.timer
    assert_equal false, light.can_walk
  end

  def test_amber
    light = TrafficLight.new(direction: 'Widdershins', timer: 1, state: TrafficLight::RED_STATE)

    light.amber!

    assert_equal TrafficLight::AMBER_STATE, light.state
    assert_equal 3, light.timer
    assert_equal false, light.can_walk
  end

  def test_next_state
    light = TrafficLight.new(direction: 'Widdershins', timer: 1, state: TrafficLight::RED_STATE)

    light.next_state!

    assert_equal TrafficLight::GREEN_STATE, light.state

    light.next_state!

    assert_equal TrafficLight::AMBER_STATE, light.state

    light.next_state!

    assert_equal TrafficLight::RED_STATE, light.state
  end

  def test_going_states_red
    light = TrafficLight.new(direction: 'Widdershins', timer: 1, state: TrafficLight::RED_STATE)

    assert_equal false, light.allows_traffic?
  end

  def test_going_states_green
    light = TrafficLight.new(direction: 'Widdershins', timer: 1, state: TrafficLight::GREEN_STATE)

    assert_equal true, light.allows_traffic?
  end

  def test_going_states_amber
    light = TrafficLight.new(direction: 'Widdershins', timer: 1, state: TrafficLight::AMBER_STATE)

    assert_equal true, light.allows_traffic?
  end
end
