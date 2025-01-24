require_relative 'lib/colorize'

class PedestrianSignal
  include Colorize

  WALK = -'WALK'
  DONT_WALK = -"DON'T WALK"

  def initialize(can_walk:)
    @can_walk = can_walk
  end

  attr_accessor :can_walk

  def to_s
    if can_walk
      can_walk_text
    else
      cannot_walk_text
    end
  end

  def can_walk_text
    green(WALK)
  end

  def cannot_walk_text
    red(DONT_WALK)
  end
end
