class Competition
  class Outcome

    # MOVES = %w[ Scissor Paper Rock].freeze
    OUTCOMES_HASH = {
      rock: {
        rock: :rock,
        paper: :paper,
        scissor: :rock
      },
      paper: {
        rock: :paper,
        paper: :paper,
        scissor: :scissor
      },
      scissor: {
        rock: :rock,
        paper: :scissor,
        scissor: :scissor
      }
    }

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
      OUTCOMES_HASH[competitor_a][competitor_b]
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