class Competition
  MOVES = %w[ Scissor Paper Rock].freeze

  attr_reader :competitor_a, :competitor_b

  def initialize(competitor_a, competitor_b)
    @competitor_a = competitor_a
    @competitor_b = competitor_b
  end

  def impact_on_populations
    case outcome

    when :a then  {
      competitor_a => 2,
      competitor_b => 0
    }
    when :b then {
      competitor_a => 0,
      competitor_b => 2
    }
    when :draw then {
      competitor_a => 2,
    }
    else
      raise "Unknown outcome: #{outcome}"
    end
  end

  def outcome
    return :draw if competitor_a == competitor_b

    index_a = MOVES.index(competitor_a)
    return :b if MOVES[index_a - 1] == competitor_b

    :a
  end
end