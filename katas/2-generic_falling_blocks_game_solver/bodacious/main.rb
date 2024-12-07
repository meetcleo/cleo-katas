# This is an empty main file for your kata
# You can run it with `bundle exec ruby katas/2-generic_falling_blocks_game_solver/bodacious/main.rb`
# Feel free to add your code below and remove this comment ...
require 'bundler'
Bundler.require

class GridSolver
  attr_reader :game_plane
  def initialize(game_plane)
    @game_plane = game_plane.each_line
                            .select { |row| !row.strip.empty? }
                            .map { |row| row.tr('.▓', '01').gsub(/00|11/) { |match| match == '00' ? '1' : '0' } }
                            .reject { |row| row.match?(/1{10}/) }


    solve!
  end
  def recommended_block
    'Any'
  end

  def recommended_orientation
    :any
  end
  def solve!
    puts "plane:\n#{game_plane}"
    self
  end
end