# traffic_light_system_test.rb

require_relative '../traffic_light'
require "minitest/autorun"

class TrafficLightTest < Minitest::Test
  def test_direction_to_s
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: 'green')
    light.to_s

    assert_includes light.to_s, "Direction: Widdershins"
  end

  def test_time_left_to_s
    light = TrafficLight.new(direction: 'Widdershins', timer: 55, state: 'green')
    light.to_s

    assert_includes light.to_s, "Time left: 55s"
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
end
