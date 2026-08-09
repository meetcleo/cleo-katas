require 'minitest/autorun'

require_relative '../../solver/shape'

class TestShape < Minitest::Test
  def test_shape
    AvailableShapes.call.each do |shape|
      (1..shape.number_of_orientations).each do |n|
        puts "SHAPE: #{shape.name}, ORIENTATION: #{n}"
        puts shape.new(orientation: n).to_s
      end
    end
  end
end
