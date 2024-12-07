# frozen_string_literal: true

require 'matrix'

class Plane
  Block = Class.new(Object) do
    def to_i = raise NotImplementedError

    def taken? = raise NotImplementedError
    def empty? = !taken?
  end
  EmptyBlock = Class.new(Block) do
    def to_i = 0

    def taken? = false
  end
  TakenBlock = Class.new(Block) do
    def to_i = 1

    def taken? = true
  end

  MalformedPlane = Class.new(StandardError)

  def self.from_string(string_plane)
    lines = string_plane.split("\n")
    line_length = lines.max { _1.size }.size / 2
    rows = Array.new(lines.length) { Array.new(line_length) }
    lines.each_with_index do |line, line_index|
      line.ljust(line_length).chars.each_slice(2).with_index do |tuple, tuple_index|
        rows[line_index][tuple_index] = \
          case tuple
          in ['▓','▓']
            TakenBlock.new
          in [' ', ' ']
            EmptyBlock.new
          else
            raise MalformedPlane
          end
      end
    end

    new(rows)
  end

  def initialize(matrix)
    @matrix = Matrix[*matrix]
  end

  def at(row, col) = matrix[row, col]

  def row_size = matrix.row_size
  def col_size = matrix.column_size

  private

  attr_reader :matrix
end
