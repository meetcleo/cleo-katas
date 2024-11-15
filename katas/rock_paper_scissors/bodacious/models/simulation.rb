# frozen_string_literal: true

require_relative 'generation'
require_relative 'population'
class Simulation
  attr_accessor :total_generations
  attr_accessor :initial_rocks
  attr_accessor :initial_paper
  attr_accessor :initial_scissors
  attr_accessor :next_generation
  attr_accessor :current_generation
  def initialize(total_generations:, initial_rocks: , initial_paper: , initial_scissors: )
    @total_generations = total_generations
    @current_generation = Generation.new(
      Population.new(species: :rock, count: initial_rocks),
      Population.new(species: :paper, count: initial_paper),
      Population.new(species: :scissor, count: initial_scissors)
    )
  end

  def run!  # rubocop:disable Metrics/AbcSize
    total_generations.times do |generation_number|
      evolve!
      self.current_generation = self.next_generation
    end
    print_stats
  end

  def evolve!
    self.next_generation = Generation.new(
      Population.new(species: :rock),
      Population.new(species: :paper),
      Population.new(species: :scissor)
    )

    until current_generation.total_population_count < 2
      competitor_a = current_generation.randomly_select_competitor!
      competitor_b = current_generation.randomly_select_competitor!

      competition = Competition.new(competitor_a, competitor_b)
      competition.impact_on_populations.each do |species_name, delta|
        population = next_generation.find_population(species_name)
        population.count += delta
      end
    end
  end

  def print_stats
    next_generation.populations.each do |population|
      puts "#{population.species}: #{population.count}"
    end
  end
end
