# frozen_string_literal: true

# This is an empty main file for your kata
# You can run it with `bundle exec ruby katas/generic_falling_blocks_game_solver/bodacious/main.rb`
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
  attr_reader :block_shape, :orientation, :pattern

  def initialize(block_shape:, orientation:, pattern:)
    @block_shape = block_shape
    @orientation = orientation
    @pattern = pattern
  end

  def block_name
    block_shape.to_s.capitalize
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

  def initialize(game_plane)
    game_grid = GameGrid.new(game_plane)
    opportunities = [
      Opportunity.new(block_shape: :z, orientation: :orientation_1, pattern: Z_BLOCK_ORIENTATION_1_MATRIX),
      Opportunity.new(block_shape: :line, orientation: :orientation_2, pattern: LINE_BLOCK_ORIENTATION_2_MATRIX),
      Opportunity.new(block_shape: :l, orientation: :orientation_2, pattern: L_BLOCK_ORIENTATION_1_MATRIX),
      Opportunity.new(block_shape: :l, orientation: :orientation_3, pattern: L_BLOCK_ORIENTATION_2_MATRIX),
      Opportunity.new(block_shape: :l, orientation: :orientation_4, pattern: L_BLOCK_ORIENTATION_3_MATRIX),
      Opportunity.new(block_shape: :z, orientation: :orientation_2, pattern: Z_BLOCK_ORIENTATION_2_MATRIX),
      Opportunity.new(block_shape: :square, orientation: :any, pattern: SQUARE_BLOCK_MATRIX),
      Opportunity.new(block_shape: :line, orientation: :orientation_1, pattern: LINE_BLOCK_ORIENTATION_1_MATRIX),
      Opportunity.new(block_shape: :any, orientation: :any, pattern: Matrix[]) # null matcher
    ]
    @best_opportunity = opportunities.detect do |opportunity|
      game_grid.include_submatrix?(opportunity.pattern)
    end
  end

  def recommended_block
    best_opportunity.block_name
  end

  def recommended_orientation
    best_opportunity.orientation
  end
end
