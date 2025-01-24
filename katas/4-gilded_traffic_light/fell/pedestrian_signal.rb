# frozen_string_literal: true

class PedestrianSignal
  def initialize(can_walk:, direction:)
    @direction = direction
    @can_walk = can_walk
  end

  attr_reader :can_walk, :direction
end
