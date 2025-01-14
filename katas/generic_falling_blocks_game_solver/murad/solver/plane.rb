# frozen_string_literal: true

require 'matrix'

class Plane
  Block = Class.new(Object) do
    def to_i = raise NotImplementedError
    def to_s = raise NotImplementedError

    def taken? = raise NotImplementedError
    def empty? = !taken?
  end
  EmptyBlock = Class.new(Block) do
    def to_i = 0
    def to_s = '  '

    def taken? = false
  end
  TakenBlock = Class.new(Block) do
    def to_i = 1
    def to_s = '▓▓'

    def taken? = true
  end

  MalformedPlane = Class.new(StandardError)

  def self.from_string(string_plane)
    lines = string_plane.split("\n")
    line_length = lines.max { _1.size }.size / 2
    rows = Array.new(lines.length) { Array.new(line_length) }
    lines.each_with_index do |line, line_index|
      line.ljust(line_length * 2).chars.each_slice(2).with_index do |tuple, tuple_index|
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

    new(Matrix[*rows])
  end

  def initialize(matrix)
    @matrix = matrix
  end

  def at(row, col) = matrix[row, col]

  def row_size = matrix.row_size
  def col_size = matrix.column_size

  def each_with_index
    matrix.each_with_index do |elem, row, col|
      yield elem, row, col
    end
  end

  def rotate(n)
    n %= 4
    case n
    when 0
      self.class.new(matrix)
    when 1
      self.class.new(Matrix.build(col_size, row_size) { |row, col| matrix[row_size - col - 1, row] })
    when 2
      self.class.new(Matrix.build(row_size, col_size) { |row, col| matrix[row_size - row - 1, col_size - col - 1] })
    when 3
      self.class.new(Matrix.build(col_size, row_size) { |row, col| matrix[col, col_size - row - 1] })
    end
  end

  def level?
    matrix.row_vectors.all? do |row_vector|
      row_vector.to_a.map(&:to_i).uniq.size == 1
    end
  end

  def to_s
    matrix.row_vectors.map { _1.to_a.join('') }.join("\n")
  end

  private

  attr_reader :matrix
end
