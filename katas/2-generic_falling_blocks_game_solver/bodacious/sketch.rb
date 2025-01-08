# frozen_string_literal: true

# This is an empty main file for your kata
# You can run it with `bundle exec ruby katas/generic_falling_blocks_game_solver/bodacious/main.rb`
# Feel free to add your code below and remove this comment ...
require 'bundler'
Bundler.require
require 'matrix'

class GridSolver
  attr_reader :game_plane

  SQUARE_BLOCK_MATRIX = Matrix[
    [0,0],
    [0,0]
  ]

  LINE_BLOCK_ORIENTATION_1_MATRIX = Matrix[
    [0],
    [0],
    [0],
    [0]
  ]

  LINE_BLOCK_ORIENTATION_2_MATRIX = Matrix[
    [0,0,0,0],
  ]

  Z_BLOCK_ORIENTATION_1_MATRIX = Matrix[
    [0,0,0],
    [1,0,0],
  ]

  Z_BLOCK_ORIENTATION_2_MATRIX = Matrix[
    [0, 0,],
    [0, 1],
  ]

  L_BLOCK_ORIENTATION_2_MATRIX = Matrix[
    [0,0,0],
    [0,1,1],
  ]
  L_BLOCK_ORIENTATION_3_MATRIX = Matrix[
    [0,0],
    [1,0],
    [1,0],
  ]
  L_BLOCK_ORIENTATION_4_MATRIX = Matrix[
    [0, 0, 0],
  ]

  def initialize(game_plane)
    @game_plane = game_plane.each_line
                            .select { |row| !row.strip.empty? }
                            .map do |row|
      row.chars.each_slice(2).map { |pair| pair.first }
         .map { |char| char == '▓' ? 1 : 0 }[0..-2]

    end
    @game_plane = Matrix.rows(@game_plane)
    solve!
  end
  def recommended_block
    case
    when contains_submatrix?(game_plane, Z_BLOCK_ORIENTATION_1_MATRIX)
      'Z'
    when contains_submatrix?(game_plane, LINE_BLOCK_ORIENTATION_2_MATRIX)
      'Line'
    when contains_submatrix?(game_plane, L_BLOCK_ORIENTATION_2_MATRIX)
      'L'

    when contains_submatrix?(game_plane, L_BLOCK_ORIENTATION_3_MATRIX)
      'L'

    when contains_submatrix?(game_plane, L_BLOCK_ORIENTATION_4_MATRIX)
      'L'
    when contains_submatrix?(game_plane, Z_BLOCK_ORIENTATION_2_MATRIX)
      'Z'
    when contains_submatrix?(game_plane, SQUARE_BLOCK_MATRIX)
      'Square'
    when contains_submatrix?(game_plane, LINE_BLOCK_ORIENTATION_1_MATRIX)
      'Line'
    else
      'Any'
    end
  end

  def recommended_orientation
    case
    when contains_submatrix?(game_plane, Z_BLOCK_ORIENTATION_1_MATRIX)
      :orientation_1
    when contains_submatrix?(game_plane, LINE_BLOCK_ORIENTATION_2_MATRIX)
      :orientation_2
    when contains_submatrix?(game_plane, L_BLOCK_ORIENTATION_2_MATRIX)
      :orientation_2
    when contains_submatrix?(game_plane, L_BLOCK_ORIENTATION_3_MATRIX)
      :orientation_3
    when contains_submatrix?(game_plane, L_BLOCK_ORIENTATION_4_MATRIX)
      :orientation_4

    when contains_submatrix?(game_plane, Z_BLOCK_ORIENTATION_2_MATRIX)
      :orientation_2
    when contains_submatrix?(game_plane, SQUARE_BLOCK_MATRIX)
      :any
    when contains_submatrix?(game_plane, LINE_BLOCK_ORIENTATION_1_MATRIX)
      :orientation_1
    else
      :any
    end
  end
  def solve!
    self
  end

  private
  def contains_submatrix?(matrix, submatrix)
    matrix_rows = matrix.row_count
    matrix_cols = matrix.column_count
    submatrix_rows = submatrix.row_count
    submatrix_cols = submatrix.column_count

    (0..(matrix_rows - submatrix_rows)).each do |x|
      (0..(matrix_cols - submatrix_cols)).each do |y|
        match = true

        (0...submatrix_rows).each do |sub_x|
          (0...submatrix_cols).each do |sub_y|
            if matrix[x + sub_x, y + sub_y] != submatrix[sub_x, sub_y]
              match = false
              break
            end
          end
          break unless match
        end

        return true if match
      end
    end

    false
  end
end
