# frozen_string_literal: true

# This sketch illustrates the initial approach, without more structured
# domain modelling

MOVES = %i[ scissor paper rock ].freeze

current_generation = {
  rock: 100,
  paper: 100,
  scissor: 100
}

def weighted_random_selection(hash)
  # Sum the weights
  total_weight = hash.values.sum

  # Generate a random number up to the total weight
  random_pick = rand(total_weight)

  # Iterate over the hash and subtract weights until reaching zero
  hash.each do |key, weight|
    return key if random_pick < weight
    random_pick -= weight
  end
end

def determine_winner(competitor_a, competitor_b)
  index_a = MOVES.index(competitor_a)
  if MOVES[index_a - 1] == competitor_b
    competitor_b
  else
    competitor_a
  end
end
1_00.times do
  next_generation = { rock: 0, paper: 0, scissor: 0}
  until current_generation.values.sum.zero?
    competitor_a, competitor_b = *2.times.map { weighted_random_selection(current_generation) }
    winning_species = determine_winner(competitor_a, competitor_b)
    current_generation[competitor_a] -= 1
    current_generation[competitor_b] -= 1
    next_generation[winning_species] += 2
  end
  current_generation = next_generation
end

current_generation.each do |species, count|
  puts "#{species}: #{count}"
end

