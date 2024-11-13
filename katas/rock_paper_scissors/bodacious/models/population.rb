# frozen_string_literal: true

class Population
  require 'forwardable'
  extend Forwardable

  attr_reader :species, :counter
  def_delegator :counter, :value, :count
  def initialize(species:, count: 0)
    @species = species
    @counter = Concurrent::AtomicFixnum.new(count)
  end

  def randomly_select_competitor!
    counter.decrement
    species
  end

end