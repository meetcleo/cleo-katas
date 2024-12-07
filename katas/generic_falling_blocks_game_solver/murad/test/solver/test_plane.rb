require 'minitest/autorun'

require_relative '../../solver/plane'

class TestPlane < Minitest::Test
  def test_simple_plane
    game_plane = <<~PLANE
      
      
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    PLANE
    plane = Plane.from_string(game_plane)

    assert_equal 10, plane.col_size
    assert_equal 6, plane.row_size
    assert plane.at(0, 0).empty?
    assert plane.at(5, 9).taken?
  end
end
