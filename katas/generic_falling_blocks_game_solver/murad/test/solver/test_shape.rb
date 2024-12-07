require 'minitest/autorun'

require_relative '../../solver/shape'

class TestShape < Minitest::Test
  def test_shape
    Shape::AVAILABLE_SHAPES.each do |shape|
      (1..4).each do |n|
        puts "ORIENTATION: #{n}"
        puts shape.orientation(n)
      end
    end
  end
end
