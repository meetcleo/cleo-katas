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
      Population.new(species: "Rock", count: initial_rocks),
      Population.new(species: "Paper", count: initial_paper),
      Population.new(species: "Scissor", count: initial_scissors)
    )
  end

  def run!  # rubocop:disable Metrics/AbcSize
    total_generations.times do |generation_number|
      evolve!
      print_stats
      self.current_generation = self.next_generation
    end
  end

  def evolve!
    self.next_generation = Generation.new(
      Population.new(species: "Rock"),
      Population.new(species: "Paper"),
      Population.new(species: "Scissor")
    )
    until current_generation.total_population_count < 2
      competitor_a = current_generation.randomly_select_competitor!
      competitor_b = current_generation.randomly_select_competitor!

      competition = Competition.new(competitor_a.class.name, competitor_b.class.name)
      competition.impact_on_populations.each do |species_class, delta|
        population = next_generation.populations.find { _1.species == species_class }
        population.counter.increment(delta)
      end
    end
  end

  def print_stats
    next_generation.populations.each do |population|
      puts "#{population.species.name}: #{population.count}"
    end
  end
end
