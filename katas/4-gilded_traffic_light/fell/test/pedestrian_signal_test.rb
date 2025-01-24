require_relative '../pedestrian_signal'
require "minitest/autorun"

class PedestrianSignalTest < Minitest::Test
  def test_direction
    signal = PedestrianSignal.new(direction: 'Widdershins', can_walk: true)

    assert_equal 'Widdershins', signal.direction
  end

  def test_can_walk
    signal = PedestrianSignal.new(direction: 'Widdershins', can_walk: true)

    assert_equal true, signal.can_walk
  end
end
