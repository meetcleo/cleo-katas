# frozen_string_literal: true

require_relative './plane'

class Shape
  def self.canonical_shape = raise NotImplementedError
  def self.number_of_orientations = raise NotImplementedError
  def self.name = raise NotImplementedError

  def plane = Plane.from_string(self.class.canonical_shape).rotate(orientation - 1)

  def initialize(orientation:)
    @orientation = orientation
  end

  def to_s = plane.to_s

  private

  attr_reader :orientation
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
