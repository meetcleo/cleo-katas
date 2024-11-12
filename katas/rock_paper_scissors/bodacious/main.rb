# frozen_string_literal: true

require 'bundler/inline'
gemfile do
  source 'https://rubygems.org'
  gem 'matrix'
  gem 'concurrent-ruby'
  gem 'singleton'
end


class Simulation
  include Singleton
  attr_accessor :total_generations
  attr_accessor :initial_rocks
  attr_accessor :initial_paper
  attr_accessor :initial_scissors

end

require 'optparse'
OptionParser.new do |opts|
  opts.banner = 'Usage: ruby main.rb [options]'

  opts.on('-gGENERATIONS', '--generations=GENERATIONS', Integer, 'Number of generations') do |generations|
    Simulation.instance.total_generations = generations
  end

  opts.on('--rROCK', '--rock=ROCK', Integer, 'Initial number of rocks') do |rocks|
    Simulation.instance.initial_rocks = rocks
  end
  opts.on('--pPAPER', '--paper=PAPER', Integer, 'Initial number of paper') do |paper|
    Simulation.instance.initial_paper = paper
  end
  opts.on('--sSCISSOR', '--scissor=SCISSOR', Integer, 'Initial number of scissors') do |scissors|
    Simulation.instance.initial_scissors = scissors
  end
end.parse!

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

  def outcome
    index1 = MOVES.index competitor_a.class_name
    index2 = MOVES.index competitor_b.class_name
    OUTCOMES[index1, index2]
  end

  def run!
    case outcome

    when :b then competitor_a.reproduce!
    when :a then competitor_b.reproduce!
    when :draw
      competitor_a.partial_reproduce!
      competitor_b.partial_reproduce!
    end
    competitor_a.die!
    competitor_b.die!
  end
end

module Competitor
  def class_name
    self.class.name
  end

end

class Competition
  attr_reader :competitor_a, :competitor_b
  def initialize(competitor_a, competitor_b)
    @competitor_a = competitor_a
    @competitor_b = competitor_b
  end

end

module Populatable
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def population_counter
      @population_counter ||= PopulationCounter.new
    end
  end

  def increment_population(count = 1)
    self.class.population_counter.increment(count)
  end

  def decrement_population(count = 1)
    self.class.population_counter.decrement(count)
  end
  alias die! decrement_population
  alias partial_reproduce! increment_population

  def reproduce!
    self.class.population_counter.increment(2)
  end
end

class Rock
  include Competitor
  include Populatable
end

class Paper
  include Competitor
  include Populatable
end

class Scissor
  include Competitor
  include Populatable
end

class PopulationCounter
  require 'concurrent-ruby'
  require 'forwardable'

  extend Forwardable

  attr_reader :value

  def_delegators :value, :increment, :decrement
  def_delegator :value, :value, :count

  def initialize(initial_value = 0)
    @value = Concurrent::AtomicFixnum.new(initial_value)
  end
end

class Generation
  def run
    total_population = Rock.population_counter.count.times.map { Rock.new} + Paper.population_counter.count.times.map { Paper.new} + Scissor.population_counter.count.times.map { Scissor.new}
    until total_population.size < 2
      random_pair = total_population.sample(2)
      total_population.delete(random_pair.first)
      total_population.delete(random_pair.last)
      Competition.new(random_pair.first, random_pair.last).run!
    end
  end
end
Rock.population_counter.increment(100)
Paper.population_counter.increment(100)
Scissor.population_counter.increment(100)

Simulation.instance.total_generations.times { Generation.new.run }
puts "Rocks: #{Rock.population_counter.count}"
puts "Papers: #{Paper.population_counter.count}"
puts "Scissors: #{Scissor.population_counter.count}"
