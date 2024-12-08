# frozen_string_literal: true

require_relative './plane'
require_relative './shape'

class Solver
  def initialize(game_plane)
    @plane = Plane.from_string(game_plane)
    @recommendations = []
    solve!
    find_lowest_row_recommendations!
    raise "More than one recommendation left. Not handled at the moment." if recommendations.size > 1
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
    lowest_row = recommendations.max_by(&:row_idx).row_idx
    recommendations.reject! { _1.row_idx != lowest_row }
  end
end

Recommendation = Struct.new(:shape_name, :orientation, :row_idx, :col_idx, keyword_init: true)