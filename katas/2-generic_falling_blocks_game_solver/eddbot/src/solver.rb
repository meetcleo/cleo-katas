# frozen_string_literal: true

class Solver
  def initialize(game_plane)
    @game_plane = game_plane
  end

  # bounds checking
  def get_val(row_val, col_val)
    return 1 if row_val >= game_board.size || col_val >= game_board.first.size || row_val.negative? || col_val.negative?

    game_board[row_val][col_val]
  end

  def recommended_block
    # brute force

    # for each 0 square on the gameboard, from bottom to top
    # superimpose each piece over the board, and add one to each
    # grid num

    # if all of the nums are 1, then the shape fits
    # otherwise the shape doens't

    # we need a way to check which was found first, and simply return it

    5.downto(0).to_a.each do |row|
      next if game_board[row].sum == 10 # skip if row is filled

      if game_board[row].sum.zero? && row <= 1 # lob any old shit in if the rows are clear
        self.orientation = :any

        return 'Any'
      end

      recs = []
      0.upto(9).to_a.each do |col|
        # if the block is filled, just skip
        next if game_board[row][col] == 1

        square = get_val(row, col) + get_val(row, col + 1) + get_val(row - 1, col) + get_val(row - 1, col + 1)

        if square.zero?
          score = []
          # how are we going to check the score?
          score << 10 if game_board[row].sum == 8
          score << 10 if game_board[row - 1].sum == 8

          recs << { shape: 'Square', score: score.sum, orientation: :any }
        end

        upwards_line = get_val(row, col) + get_val(row - 1, col) + get_val(row - 2, col) + get_val(row - 3, col)

        if upwards_line.zero?

          score = []

          score << 10 if game_board[row].sum == 9
          score << 10 if game_board[row - 1].sum == 9
          score << 10 if game_board[row - 2].sum == 9
          score << 10 if game_board[row - 3].sum == 9

          recs << { shape: 'Line', score: score.sum, orientation: :orientation_1 }
        end

        sideways_line = get_val(row, col) + get_val(row, col + 1) + get_val(row, col + 2) + get_val(row, col + 3)

        if sideways_line.zero?
          score = 0

          score = 10 if game_board[row].sum == 6

          recs << { shape: 'Line', score: score, orientation: :orientation_2 }
        end

        z_block_sideways = get_val(row, col) + get_val(row, col + 1) + get_val(row - 1, col - 1) + get_val(row - 1, col)

        if z_block_sideways.zero?
          score = []

          score << 10 if game_board[row].sum == 8
          score << 10 if game_board[row - 1].sum == 7

          recs << { shape: 'Z', score: score.sum, orientation: :orientation_1 }
        end

        z_block_upwards = get_val(row,
                                  col) + get_val(row - 1, col) + get_val(row - 1, col + 1) + get_val(row - 2, col + 1)

        if z_block_upwards.zero?
          score = []

          score << 10 if game_board[row].sum == 9
          score << 10 if game_board[row - 1].sum == 8
          score << 10 if game_board[row - 2].sum == 9

          recs << { shape: 'Z', score: score.sum, orientation: :orientation_2 }
        end

        l_block_1 = get_val(row, col) + get_val(row - 1, col) + get_val(row - 2, col) + get_val(row - 2, col - 1)
        if l_block_1.zero?
          score = []

          score << 10 if game_board[row].sum == 9
          score << 10 if game_board[row - 1].sum == 9
          score << 10 if game_board[row - 2].sum == 8

          recs << { shape: 'L', score: score.sum, orientation: :orientation_3 }
        end

        l_block_2 = get_val(row, col) + get_val(row - 1, col) + get_val(row - 1, col + 1) + get_val(row - 1, col + 2)
        if l_block_2.zero?
          score = []

          score << 10 if game_board[row].sum == 9
          score << 10 if game_board[row - 1].sum == 7

          recs << { shape: 'L', score: score.sum, orientation: :orientation_2 }
        end

        l_block_3 = get_val(row, col) + get_val(row, col + 1) + get_val(row, col + 2) + get_val(row - 1, col + 2)
        if l_block_3.zero?
          score = []

          score << 10 if game_board[row].sum == 7
          score << 10 if game_board[row - 1].sum == 9

          recs << { shape: 'L', score: score.sum, orientation: :orientation_4 }
        end

        # for each row find the max score and return it
        next unless recs.any?

        winner = recs.max { |a, b| a[:score] <=> b[:score] }

        self.orientation = winner[:orientation]

        return winner[:shape]
      end
    end
  end

  def recommended_orientation
    recommended_block

    orientation
  end

  private

  attr_reader :game_plane

  attr_accessor :orientation

  def game_board
    @game_board ||= game_plane.split("\n").map do |line|
      if line == ''
        Array.new(10, 0)
      else
        line.chars.each_slice(2).map { _1.join == '▓▓' ? 1 : 0 }
      end
    end
  end
end
