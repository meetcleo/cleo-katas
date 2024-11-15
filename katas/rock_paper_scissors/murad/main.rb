# This is an empty main file for your kata
# You can run it with `bundle exec ruby katas/rock_paper_scissors/murad/main.rb`
# Feel free to add your code below and remove this comment ...

require 'bundler/inline'
require 'optparse'

require_relative './world'

gemfile do
  source 'https://rubygems.org'

  # Add your gems here
end

options = {}
OptionParser.new do |parser|
  parser.on("--population-size=SIZE", Integer, "Population size") do |size|
    options[:population_size] = size
  end
  parser.on("--days=DAYS", Integer, "For how many days to run the simulation") do |days|
    options[:days] = days
  end
  parser.on("--rocks-size=size", Integer, "Rocks population size") do |size|
    options[:rocks_size] = size
  end
  parser.on("--papers-size=size", Integer, "Papers population size") do |size|
    options[:papers_size] = size
  end
  parser.on("--scissors-size=size", Integer, "Scissors population size") do |size|
    options[:scissors_size] = size
  end
  parser.on("--seed=seed", Integer, "Seed to use") do |seed|
    options[:seed] = seed
  end
end.parse!

world = World.new(
  population_size: options[:population_size],
  days: options[:days],
  rocks_size: options[:rocks_size],
  papers_size: options[:papers_size],
  scissors_size: options[:scissors_size],
  seed: options[:seed],
)

world.run

pp world.state
