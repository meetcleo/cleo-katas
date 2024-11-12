# frozen_string_literal: true

require 'bundler/inline'
gemfile do
  source 'https://rubygems.org'
  gem 'matrix'
  gem 'concurrent-ruby'
end

require 'optparse'
require 'forwardable'
class Generation
  attr_reader :populations
  def initialize(*populations)
    @populations = populations
  end

  def total_population_count
    populations.sum(&:count)
  end
  def randomly_select_competitor!
    total_population_count = populations.sum(&:count)
    random_creature_index = rand(total_population_count) + 1
    offset = 0
    selected_population = populations.find do |population|
      break population if (offset..offset + population.count).include?(random_creature_index)

      offset += population.count
      nil
    end
    selected_population.randomly_select_competitor!
  end
end
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
      Population.new(species: Rock, count: initial_rocks),
      Population.new(species: Paper, count: initial_paper),
      Population.new(species: Scissor, count: initial_scissors)
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
      Population.new(species: Rock),
      Population.new(species: Paper),
      Population.new(species: Scissor)
    )
    until current_generation.total_population_count < 2
      competitor_a = current_generation.randomly_select_competitor!
      competitor_b = current_generation.randomly_select_competitor!

      competition = Competition.new(competitor_a, competitor_b)
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

class Competition
  MOVES = %w[Rock Paper Scissor].freeze

  OUTCOMES = Matrix[
    %i[draw b a],
    %i[a draw b],
    %i[b a draw]
  ]

  attr_reader :competitor_a, :competitor_b

  def initialize(competitor_a, competitor_b)
    @competitor_a = competitor_a
    @competitor_b = competitor_b
  end

  def impact_on_populations
    case outcome

    when :a then  {
      competitor_a.class => 2,
      competitor_b.class => 0
    }
    when :b then {
    competitor_a.class => 0,
    competitor_b.class => 2
    }
    when :draw then {
      competitor_a.class => 2,
    }
    else
      raise "Unknown outcome: #{outcome}"
    end
  end

  private


  def outcome
    index1 = MOVES.index competitor_a.class.name
    index2 = MOVES.index competitor_b.class.name
    OUTCOMES[index1, index2]
  end
end

class Creature
end

class Rock <  Creature
end

class Paper < Creature
end

class Scissor < Creature
end

class Population

  extend Forwardable

  attr_reader :species, :counter
  def_delegator :counter, :value, :count
  def initialize(species:, count: 0)
    @species = species
    @counter = Concurrent::AtomicFixnum.new(count)
  end

  def randomly_select_competitor!
    counter.decrement
    species.new
  end

end

options = {}

OptionParser.new do |opts|
  opts.banner = 'Usage: ruby main.rb [options]'

  opts.on('-gGENERATIONS', '--generations=GENERATIONS', Integer, 'Number of generations') do |generations|
    options[:total_generations] = generations
  end

  opts.on('--rROCK', '--rock=ROCK', Integer, 'Initial number of rocks') do |rocks|
    options[:initial_rocks] = rocks

  end
  opts.on('--pPAPER', '--paper=PAPER', Integer, 'Initial number of paper') do |paper|
    options[:initial_paper] = paper
  end
  opts.on('--sSCISSOR', '--scissor=SCISSOR', Integer, 'Initial number of scissors') do |scissors|
    options[:initial_scissors] = scissors
  end
end.parse!
Simulation.new(**options).run!
