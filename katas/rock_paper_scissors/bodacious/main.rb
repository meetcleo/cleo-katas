require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'matrix'
  gem 'concurrent-ruby'
end

class Competition

  MOVES = ['Rock','Paper', 'Scissor']

  OUTCOMES = Matrix[
    [:draw, :b, :a],
    [:a, :draw, :b],
    [:b, :a, :draw]
  ]

  attr_reader :competitor_a, :competitor_b

  def initialize(competitor_a, competitor_b)
    @competitor_a = competitor_a
    @competitor_b = competitor_b
  end

  def outcome
    index1 = MOVES.index competitor_a
    index2 = MOVES.index competitor_b
    OUTCOMES[index1, index2]
  end
end

module Competitor
  def class_name
    self.class.name
  end

  def compete(opponent)
    case Competition.new(self.class_name, opponent.class_name).outcome

    when :b then decrement_population
    when :a then increment_population(2)
    when :draw
      increment_population(1)
      increment_population(1)
    end
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

  def increment_population(count=1)
    self.class.population_counter.increment(count)
  end

  def decrement_population(count=1)
    self.class.population_counter.decrement(count)
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

Rock.population_counter.increment(100)
Paper.population_counter.increment(100)
Scissor.population_counter.increment(100)

Rock.new.compete(Paper.new)
Rock.new.compete(Scissor.new)
Paper.new.compete(Scissor.new)

puts "Rocks: #{Rock.population_counter.count}"
puts "Papers: #{Paper.population_counter.count}"
puts "Scissors: #{Scissor.population_counter.count}"
