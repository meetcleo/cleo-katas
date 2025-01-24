require_relative '../traffic_light'
require 'minitest/autorun'

class TrafficLightTest < Minitest::Test
  def test_direction
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: 'green')

    assert_equal 'Widdershins', light.direction
  end

  def test_state
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: 'green')

    # reader
    assert_equal 'green', light.state

    # writer
    light.state = 'test_state'
    assert_equal 'test_state', light.state
  end

  def test_timer
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: 'green')

    # reader
    assert_equal 55, light.timer

    # writer
    light.timer = 101
    assert_equal 101, light.timer
  end

  def test_direction_to_s
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: 'green')
    light.to_s

    assert_includes light.to_s, 'Direction: Widdershins'
  end

  def test_time_left_to_s
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: 'green')
    light.to_s

    assert_includes light.to_s, 'Time left: 55s'
  end

  def test_red_light_to_s
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: 'red')

    light.to_s

    assert_includes light.to_s, "\e[31mred\e[0m"
  end

  def test_green_light_to_s
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: 'green')

    light.to_s

    assert_includes light.to_s, "\e[32mgreen\e[0m"
  end

  def test_amber_light_to_s
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: 'amber')

    light.to_s

    assert_includes light.to_s, "\e[33mamber\e[0m"
  end

  def test_amber_light_to_s
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: 'amber')

    light.to_s

    assert_includes light.to_s, "\e[33mamber\e[0m"
  end

  def test_progress
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: 'green')
    light.progress

    assert_equal 54, light.timer
  end
end
