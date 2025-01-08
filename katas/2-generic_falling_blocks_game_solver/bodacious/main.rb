# frozen_string_literal: true

# This is an empty main file for your kata
# You can run it with `bundle exec ruby katas/2-generic_falling_blocks_game_solver/bodacious/main.rb`
# Feel free to add your code below and remove this comment ...
require 'bundler'
Bundler.require

class GameGrid < DelegateClass(Matrix)
  def initialize(game_plane)
    matrix_data = game_plane.each_line
                            .reject { |row| row.strip.empty? }
                            .map do |row|
      row.chars.each_slice(2).map(&:first)
         .map { |char| char == '▓' ? 1 : 0 }[0..-2]
    end
    super(Matrix.rows(matrix_data))
  end

  def include_submatrix?(submatrix)
    submatrix_rows = submatrix.row_count
    submatrix_cols = submatrix.column_count

    delta_row_indices = (0..(row_count - submatrix_rows)).to_a
    delta_col_indices = (0..(column_count - submatrix_cols)).to_a
    delta_indices_cartesian_product = delta_row_indices.product(delta_col_indices)
    submatrix_rows_and_columns_cartesian_product = (0...submatrix_rows).to_a.product((0...submatrix_cols).to_a)

    delta_indices_cartesian_product.lazy.each do |x, y|
      match = true

      submatrix_rows_and_columns_cartesian_product.each do |sub_x, sub_y|
        match = self[x + sub_x, y + sub_y] == submatrix[sub_x, sub_y]
        break unless match
      end

      return true if match
    end

    false
  end
end

class Opportunity
  extend Forwardable
  attr_reader :shape, :orientation, :pattern

  def initialize(shape:, orientation:, pattern:)
    @shape = shape
    @orientation = orientation
    @pattern = pattern
  end
  def_delegator :shape, :long_name, :shape_long_name
  def_delegator :orientation, :long_name, :orientation_long_name
end

class BlockShape
  attr_reader :short_name

  def initialize(short_name = :any)
    @short_name = short_name
  end

  def long_name
    short_name.to_s.capitalize
  end
end

class BlockOrientation
  attr_reader :number

  def initialize(number = 0)
    @number = number
  end

  def long_name
    return :any if number.zero?

    :"orientation_#{number}"
  end
end

class GridSolver
  attr_reader :game_plane, :best_opportunity

  SQUARE_BLOCK_MATRIX = Matrix[
    [0, 0],
    [0, 0]
  ]

  LINE_BLOCK_ORIENTATION_1_MATRIX = Matrix[
    [0],
    [0],
    [0],
    [0]
  ]

  LINE_BLOCK_ORIENTATION_2_MATRIX = Matrix[
    [0, 0, 0, 0],
  ]

  Z_BLOCK_ORIENTATION_1_MATRIX = Matrix[
    [0, 0, 0],
    [1, 0, 0],
  ]

  Z_BLOCK_ORIENTATION_2_MATRIX = Matrix[
    [0, 0],
    [0, 1],
  ]

  L_BLOCK_ORIENTATION_1_MATRIX = Matrix[
    [0, 0, 0],
    [0, 1, 1],
   ]
  L_BLOCK_ORIENTATION_2_MATRIX = Matrix[
    [0, 0],
    [1, 0],
    [1, 0],
  ]

  L_BLOCK_ORIENTATION_3_MATRIX = Matrix[
    [0, 0, 0],
  ]

  # rubocop:disable Metrics/MethodLength
  def initialize(game_plane)
    game_grid = GameGrid.new(game_plane)
    opportunities = [
      Opportunity.new(shape: BlockShape.new(:z),
                      orientation: BlockOrientation.new(1),
                      pattern: Z_BLOCK_ORIENTATION_1_MATRIX),
      Opportunity.new(shape: BlockShape.new(:line),
                      orientation: BlockOrientation.new(2),
                      pattern: LINE_BLOCK_ORIENTATION_2_MATRIX),
      Opportunity.new(shape: BlockShape.new(:l),
                      orientation: BlockOrientation.new(2),
                      pattern: L_BLOCK_ORIENTATION_1_MATRIX),
      Opportunity.new(shape: BlockShape.new(:l),
                      orientation: BlockOrientation.new(3),
                      pattern: L_BLOCK_ORIENTATION_2_MATRIX),
      Opportunity.new(shape: BlockShape.new(:l),
                      orientation: BlockOrientation.new(4),
                      pattern: L_BLOCK_ORIENTATION_3_MATRIX),
      Opportunity.new(shape: BlockShape.new(:z),
                      orientation: BlockOrientation.new(2),
                      pattern: Z_BLOCK_ORIENTATION_2_MATRIX),
      Opportunity.new(shape: BlockShape.new(:square),
                      orientation: BlockOrientation.new,
                      pattern: SQUARE_BLOCK_MATRIX),
      Opportunity.new(shape: BlockShape.new(:line),
                      orientation: BlockOrientation.new(1),
                      pattern: LINE_BLOCK_ORIENTATION_1_MATRIX),
      Opportunity.new(shape: BlockShape.new,
                      orientation: BlockOrientation.new,
                      pattern: Matrix[]) # null matcher
    ]
    @best_opportunity = opportunities.detect do |opportunity|
      game_grid.include_submatrix?(opportunity.pattern)
    end
  end
  # rubocop:enable Metrics/MethodLength

  def recommended_block
    best_opportunity.shape_long_name
  end

  def recommended_orientation
    best_opportunity.orientation_long_name
  end
end
