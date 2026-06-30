require_relative '../pedestrian_signal'
require 'minitest/autorun'

class PedestrianSignalTest < Minitest::Test
  def test_can_walk
    signal = PedestrianSignal.new(can_walk: true)

    assert_equal true, signal.can_walk

    signal.can_walk = false

    assert_equal false, signal.can_walk
  end

  def test_can_walk_to_s
    signal = PedestrianSignal.new(can_walk: true)

    assert_equal "\e[32mWALK\e[0m", signal.to_s
  end

  def test_cannot_walk_to_s
    signal = PedestrianSignal.new(can_walk: false)

    assert_equal "\e[31mDON'T WALK\e[0m", signal.to_s
  end
end
