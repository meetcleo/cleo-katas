# frozen_string_literal: true

require 'bundler/inline'
gemfile do
  source 'https://rubygems.org'
  gem 'matrix'
  gem 'concurrent-ruby'
end

require 'optparse'

require_relative 'models/competition'
require_relative 'models/simulation'

options = {
  total_generations: 50,
  initial_rocks: 100,
  initial_paper: 100,
  initial_scissors: 100,
}

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
