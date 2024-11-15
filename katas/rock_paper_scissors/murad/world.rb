# frozen_string_literal: true

class World
  def initialize(population_size:, days:, rocks_size: nil, papers_size: nil, scissors_size: nil, seed: nil)
    @rocks = rocks_size || population_size
    @papers = papers_size || population_size
    @scissors = scissors_size || population_size
    @days = days
    @seed = seed || Random.new_seed
    Random.srand(@seed)
  end

  def run
    @start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    until days.zero?
      puts state
      break if a_species_have_eradicated_all_other_species?

      reset_offspring_count

      find_matches_for_rocks
      find_matches_for_papers
      find_matches_for_scissors

      youre_gonna_go_far_kid
      progress_time
    end
  end

  def state
    {
      days:,
      rocks:,
      papers:,
      scissors:,
      seed:,
      elapsed_time:,
    }
  end

  private

  attr_accessor :rocks, :papers, :scissors, :days, :new_rocks, :new_papers, :new_scissors
  attr_reader :start_time, :seed

  def total_population
    rocks + papers + scissors
  end

  def elapsed_time
    Process.clock_gettime(Process::CLOCK_MONOTONIC) - start_time
  end

  def a_species_have_eradicated_all_other_species?
    rocks_win? || papers_win? || scissors_win?
  end

  def rocks_win?
    papers.zero? && scissors.zero?
  end

  def papers_win?
    rocks.zero? && scissors.zero?
  end

  def scissors_win?
    rocks.zero? && papers.zero?
  end

  def reset_offspring_count
    self.new_rocks = 0
    self.new_papers = 0
    self.new_scissors = 0
  end

  def youre_gonna_go_far_kid
    self.rocks = new_rocks
    self.papers = new_papers
    self.scissors = new_scissors
  end

  def progress_time
    self.days -= 1
  end

  def find_matches_for_rocks
    until rocks.zero?
      match = Random.rand(2..total_population)
      if 1 < match && match <= rocks
        rocks_draw
      elsif rocks < match && match <= rocks+papers
        paper_beats_rock
      elsif rocks+papers < match && match <= rocks+papers+scissors
        rock_beats_scissors
      else
        puts match
        raise StandardError, "you fucked up"
      end
    end
  end

  def find_matches_for_papers
    until papers.zero?
      match = Random.rand(2..total_population)
      if 1 < match && match <= papers
        papers_draw
      elsif papers < match && match <= papers+scissors
        scissors_beat_paper
      else
        puts match
        raise StandardError, "you fucked up"
      end
    end
  end

  def find_matches_for_scissors
    self.new_scissors += scissors
  end

  def rocks_draw
    self.new_rocks += 2
    self.rocks -= 2
  end

  def papers_draw
    self.new_papers += 2
    self.papers -= 2
  end

  def paper_beats_rock
    self.new_papers += 2
    self.rocks -= 1
    self.papers -= 1
  end

  def rock_beats_scissors
    self.new_rocks += 2
    self.rocks -= 1
    self.scissors -= 1
  end

  def scissors_beat_paper
    self.new_scissors += 2
    self.papers -= 1
    self.scissors -= 1
  end
end
