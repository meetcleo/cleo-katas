class Competition
  class Outcome

    MOVES = %w[ Scissor Paper Rock].freeze

    attr_reader :competitor_a, :competitor_b

    def initialize(competitor_a, competitor_b)
      @competitor_a = competitor_a
      @competitor_b = competitor_b
    end

    # The winner of the competition. Rock beats Scissors, Scissors beats Paper, Paper beats Rock. Will return
    # the name of the draw if the competitors are equal.
    #
    # @return [String]
    def winner
      index_a = MOVES.index(competitor_a)
      if MOVES[index_a - 1] == competitor_b
        competitor_b
      else
        competitor_a
      end
    end
  end

  attr_reader :competitor_a, :competitor_b

  def initialize(competitor_a, competitor_b)
    @competitor_a = competitor_a
    @competitor_b = competitor_b
  end

  # @return [Hash] population changes for each species
  def impact_on_populations
    population_changes = { competitor_a => 0, competitor_b => 0 }
    population_changes[outcome] = 2
    population_changes
  end

  private

  def outcome
    Outcome.new(competitor_a, competitor_b).winner
  end
end