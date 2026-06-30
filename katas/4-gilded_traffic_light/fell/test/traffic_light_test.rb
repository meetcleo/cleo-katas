require_relative '../traffic_light'
require 'minitest/autorun'

class TrafficLightTest < Minitest::Test
  def test_direction_to_s
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: TrafficLightState::GREEN)
    light.to_s

    assert_includes light.to_s, 'Direction: Widdershins'
  end

  def test_time_left_to_s
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: TrafficLightState::GREEN)
    light.to_s

    assert_includes light.to_s, 'Time left: 55s'
  end

  def test_red_light_to_s
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: TrafficLightState::RED)

    light.to_s

    assert_includes light.to_s, "\e[31mred\e[0m"
  end

  def test_green_light_to_s
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: TrafficLightState::GREEN)

    light.to_s

    assert_includes light.to_s, "\e[32mgreen\e[0m"
  end

  def test_amber_light_to_s
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: TrafficLightState::AMBER)

    light.to_s

    assert_includes light.to_s, "\e[33mamber\e[0m"
  end

  def test_progress_with_incomplete_timer
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: TrafficLightState::GREEN)

    light.progress!

    assert_includes light.to_s, 'green'
  end

  def test_progress_progreses_state_with_complete_timer
    light = TrafficLight.new(direction: 'Widdershins', timer: 1, state: TrafficLightState::GREEN)
    light.progress!

    assert_includes light.to_s, 'amber'
  end

  def test_inital_pedestrian_signal_status
    light = TrafficLight.new(direction: 'Widdershins', timer: 1, state: TrafficLightState::RED)

    # Even on red, pedestrians cannot walk initially
    assert_includes light.pedestrian_signal_status, "Widdershins: \e[31mDON'T WALK\e[0m"
  end

  def test_can_walk_pedestrian_signal_status
    light = TrafficLight.new(direction: 'Widdershins', timer: 1, state: TrafficLightState::AMBER)

    # Progress to red light for traffic
    light.next_state!

    assert_includes light.pedestrian_signal_status, "Widdershins: \e[32mWALK\e[0m"
  end

  def test_cannot_walk_pedestrian_signal_status
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: TrafficLightState::GREEN)

    # Run through the whole cycle once
    3.times do
      light.next_state!
    end

    assert_includes light.pedestrian_signal_status, "Widdershins: \e[31mDON'T WALK\e[0m"
  end

  def test_red
    light = TrafficLight.new(direction: 'Widdershins', timer: 1, state: TrafficLightState::GREEN)

    light.red!

    assert_equal false, light.allows_traffic?
    assert_equal true, light.allows_pedestrians?
  end

  def test_next_state
    light = TrafficLight.new(direction: 'Widdershins', timer: 1, state: TrafficLightState::RED)

    light.next_state!

    assert_includes light.to_s, 'green'

    light.next_state!

    assert_includes light.to_s, 'amber'

    light.next_state!

    assert_includes light.to_s, 'red'
  end

  def test_allows_traffic_red
    light = TrafficLight.new(direction: 'Widdershins', timer: 1, state: TrafficLightState::RED)

    assert_equal false, light.allows_traffic?
  end

  def test_allows_traffic_green
    light = TrafficLight.new(direction: 'Widdershins', timer: 1, state: TrafficLightState::GREEN)

    assert_equal true, light.allows_traffic?
  end

  def test_allows_traffic_amber
    light = TrafficLight.new(direction: 'Widdershins', timer: 1, state: TrafficLightState::AMBER)

    assert_equal true, light.allows_traffic?
  end
end
