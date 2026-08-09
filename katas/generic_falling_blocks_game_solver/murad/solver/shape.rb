# frozen_string_literal: true

require_relative './plane'

class Shape
  def self.canonical_shape = raise NotImplementedError
  def self.number_of_orientations = raise NotImplementedError
  def self.name = raise NotImplementedError

  def initialize(orientation:)
    @orientation = orientation
  end

  attr_reader :orientation

  def height = plane.row_size
  def width = plane.col_size
  def at(row, col) = plane.at(row, col)

  def to_s = plane.to_s

  def each_with_index
    plane.each_with_index do |elem, row, col|
      yield elem, row, col
    end
  end

  def taken_blocks_per_row
    result = Array.new(plane.row_size, 0)
    each_with_index { |elem, row, _col| result[row] += elem.to_i }
    result
  end

  private
  def plane = Plane.from_string(self.class.canonical_shape).rotate(orientation - 1)
end

class AvailableShapes
  def self.call = Shape.subclasses
end

class Square < Shape
  def self.canonical_shape
    <<~SHAPE
      ▓▓▓▓
      ▓▓▓▓
    SHAPE
  end

  def self.number_of_orientations = 1

  def self.name = 'Square'
end

class Line < Shape
  def self.canonical_shape
    <<~SHAPE
      ▓▓
      ▓▓
      ▓▓
      ▓▓
    SHAPE
  end

  def self.number_of_orientations = 2

  def self.name = 'Line'
end

class Z < Shape
  def self.canonical_shape
    <<~SHAPE
      ▓▓▓▓
        ▓▓▓▓
    SHAPE
  end

  def self.number_of_orientations = 2

  def self.name = 'Z'
end

class L < Shape
  def self.canonical_shape
    <<~SHAPE
      ▓▓
      ▓▓
      ▓▓▓▓
    SHAPE
  end

  def self.number_of_orientations = 4

  def self.name = 'L'
end
