# frozen_string_literal: true

class Population
  require 'forwardable'
  extend Forwardable

  attr_reader :species, :count
  attr_writer :count

  def initialize(species:, count: 0)
    @species = species
    @count = count
  end

  def randomly_select_competitor!
    self.count -= 1
    species
  end

end