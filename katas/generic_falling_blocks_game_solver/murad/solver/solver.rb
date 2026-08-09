# frozen_string_literal: true

require_relative './plane'
require_relative './shape'

class Solver
  MultiplePossibleSolutionsError = Class.new(StandardError)

  def initialize(game_plane)
    @plane = Plane.from_string(game_plane)
    return recommend_any if plane.level?

    @recommendations = []
    solve!
    find_lowest_row_recommendations!
    if recommendations.size > 1
      debug_state_msg = <<~MSG
        Pretty sure all of them are equally viable. See for yourself:
        PLANE:
        #{plane}
        RECOMMENDATIONS:
        #{recommendations.map(&:to_debug_s).join("\n")}
      MSG
      raise MultiplePossibleSolutionsError, debug_state_msg

    end
    @the_recommendation = recommendations.first
  end

  def recommended_block
    the_recommendation.shape_name
  end

  def recommended_orientation
    the_recommendation.orientation
  end

  private

  attr_reader :plane, :recommendations, :the_recommendation

  def solve!
    AvailableShapes.call.each do |shape_class|
      shape_class.number_of_orientations.times do |orientation|
        shape = shape_class.new(orientation: orientation + 1)

        0.upto(plane.row_size - shape.height) do |row_idx|
          0.upto(plane.col_size - shape.width) do |col_idx|
            next unless shape_fits_at?(shape, row_idx, col_idx)

            recommendations << Recommendation.new(
              shape_name: shape.class.name,
              orientation: shape_orientation_recommendation(shape),
              row_idx:,
              col_idx:,
              max_depth: row_idx + shape.height,
              taken_blocks_per_row: shape.taken_blocks_per_row,
              shape:,
            )
          end
        end
      end
    end
  end

  def shape_fits_at?(shape, row, col)
    shape.each_with_index do |elem, erow, ecol|
      return false if elem.to_i + plane.at(row + erow, col + ecol).to_i > 1
    end
    true
  end

  def shape_orientation_recommendation(shape)
    return :any if shape.class.number_of_orientations == 1

    "orientation_#{shape.orientation}".to_sym
  end

  def find_lowest_row_recommendations!
    lowest_end = recommendations.map(&:max_depth).max
    recommendations.reject! { _1.max_depth != lowest_end }

    lowest_start = recommendations.map(&:row_idx).max
    recommendations.reject! { _1.row_idx != lowest_start }

    # taken_blocks_per_row will be of equal sizes here
    recommendations.first.taken_blocks_per_row.size.downto(1) do |row_idx|
      biggest_value = recommendations.map { _1.taken_blocks_per_row[row_idx - 1] }.max
      recommendations.reject! { _1.taken_blocks_per_row[row_idx - 1] != biggest_value }
    end
  end

  def recommend_any
    @the_recommendation = Recommendation.new(shape_name: 'Any', orientation: :any)
  end
end

Recommendation = Struct.new(:shape_name, :orientation, :row_idx, :col_idx, :max_depth, :taken_blocks_per_row, :shape, keyword_init: true) do
  def to_debug_s = to_s + "\n" + shape.to_s
end
