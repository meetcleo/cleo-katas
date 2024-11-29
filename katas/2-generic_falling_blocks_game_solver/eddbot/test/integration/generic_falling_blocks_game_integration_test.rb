require 'minitest/autorun'
require_relative '../../src/solver'

class GenericFallingBlocksGameIntegrationTest < Minitest::Test
  def test_recommends_any_block_when_plane_is_level
    game_plane = <<~PLANE


      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    PLANE
    assert_equal 'Any', described_class.new(game_plane).recommended_block
    assert_equal :any, described_class.new(game_plane).recommended_orientation
  end

  def test_correctly_recommends_square_block_any_orientation
    game_plane = <<~PLANE


      ▓▓▓▓    ▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓    ▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    PLANE
    instance = described_class.new(game_plane)
    assert_equal 'Square', instance.recommended_block
    assert_equal :any, instance.recommended_orientation
  end

  def test_correctly_recommends_square_block_deep
    game_plane = <<~PLANE


      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓    ▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓    ▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓    ▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    PLANE
    instance = described_class.new(game_plane)
    assert_equal 'Square', instance.recommended_block
    assert_equal :any, instance.recommended_orientation
  end

  def test_correctly_recommends_line_block_orientation_1
    game_plane = <<~PLANE


      ▓▓▓▓  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    PLANE
    instance = described_class.new(game_plane)
    assert_equal 'Line', instance.recommended_block
    assert_equal :orientation_1, instance.recommended_orientation
  end

  def test_correctly_recommends_line_block_orientation_2
    game_plane = <<~PLANE


      ▓▓▓▓▓▓▓▓▓▓        ▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    PLANE
    instance = described_class.new(game_plane)
    assert_equal 'Line', instance.recommended_block
    assert_equal :orientation_2, instance.recommended_orientation
  end

  def test_correctly_recommends_z_block_orientation_1
    game_plane = <<~PLANE


      ▓▓▓▓▓▓▓▓▓▓▓▓      ▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓    ▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    PLANE
    instance = described_class.new(game_plane)
    assert_equal 'Z', instance.recommended_block
    assert_equal :orientation_1, instance.recommended_orientation
  end

  def test_correctly_recommends_z_block_orientation_2
    game_plane = <<~PLANE


      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓    ▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓  ▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    PLANE
    instance = described_class.new(game_plane)
    assert_equal 'Z', instance.recommended_block
    assert_equal :orientation_2, instance.recommended_orientation
  end

  def test_correctly_recommends_l_orientation_2
    game_plane = <<~PLANE


      ▓▓▓▓▓▓▓▓▓▓      ▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓  ▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    PLANE
    instance = described_class.new(game_plane)
    assert_equal 'L', instance.recommended_block
    assert_equal :orientation_2, instance.recommended_orientation
  end

  def test_correctly_recommends_l_orientation_3
    game_plane = <<~PLANE


      ▓▓▓▓▓▓▓▓    ▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓  ▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓  ▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    PLANE
    instance = described_class.new(game_plane)
    assert_equal 'L', instance.recommended_block
    assert_equal :orientation_3, instance.recommended_orientation
  end

  def test_correctly_recommends_l_orientation_4
    game_plane = <<~PLANE


      ▓▓▓▓▓▓▓▓      ▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    PLANE
    instance = described_class.new(game_plane)
    assert_equal 'L', instance.recommended_block
    assert_equal :orientation_4, instance.recommended_orientation
  end

  private

  def described_class
    Solver
  end
end