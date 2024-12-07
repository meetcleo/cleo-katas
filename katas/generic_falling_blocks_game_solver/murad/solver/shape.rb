# frozen_string_literal: true

require_relative './plane'

class Shape
  def self.from_string(shape_string)
    new(Plane.from_string(shape_string))
  end

  def initialize(plane)
    @plane = plane
  end

  def orientation(n)
    plane.rotate(n - 1)
  end

  def to_s = plane.to_s

  AVAILABLE_SHAPES = [
    SQUARE = from_string(<<~SHAPE
      ▓▓▓▓
      ▓▓▓▓
    SHAPE
    ),
    LINE = from_string(<<~SHAPE
      ▓▓
      ▓▓
      ▓▓
      ▓▓
    SHAPE
    ),
    Z = from_string(<<~SHAPE
      ▓▓▓▓
        ▓▓▓▓
    SHAPE
    ),
    L = from_string(<<~SHAPE
      ▓▓
      ▓▓
      ▓▓▓▓
SHAPE
    ),
  ]

  private

  attr_reader :plane
end
