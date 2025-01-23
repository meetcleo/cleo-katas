# traffic_light_system_test.rb

require_relative 'main'
require "minitest/autorun"
class TrafficLightSystemTest < Minitest::Test
  def test_initial_output
    system = TrafficLightSystem.new
    out, _err = capture_io do
      system.run
    end

    assert_includes out, "Direction: North-South, State: \e[31mred\e[0m, Time left: 10s"
    assert_includes out, "Direction: East-West, State: \e[32mgreen\e[0m, Time left: 8s"

    assert_includes out, "North-South: \e[31mDON'T WALK\e[0m"
    assert_includes out, "East-West: \e[31mDON'T WALK\e[0m"
  end

  def test_red_transitions_to_green
    system = TrafficLightSystem.new
    10.times { system.run }

    out, _err = capture_io do
      system.run
    end

    assert_includes out, "Direction: North-South, State: \e[32mgreen\e[0m, Time left: 8s"
  end

  def test_green_transitions_to_amber
    system = TrafficLightSystem.new
    8.times { system.run }

    out, _err = capture_io do
      system.run
    end

    assert_includes out, "Direction: East-West, State: \e[33mamber\e[0m, Time left: 3s"
  end

  def test_amber_transitions_to_red
    system = TrafficLightSystem.new
    11.times { system.run } # now East-West should be amber(3)

    out, _err = capture_io do
      system.run
    end

    assert_includes out, "Direction: East-West, State: \e[31mred\e[0m, Time left: 8s"
    assert_includes out, "East-West: \e[32mWALK\e[0m"
  end

  def test_opposite_direction_forced_red
    system = TrafficLightSystem.new

    10.times { system.run }
    out, _err = capture_io do
      system.run
    end

    assert_includes out, "Direction: North-South, State: \e[32mgreen\e[0m, Time left: 8s"
    assert_includes out, "Direction: East-West, State: \e[31mred\e[0m, Time left: 9s"
    assert_includes out, "East-West: \e[32mWALK\e[0m"
  end
end
