# Rock, Paper, Scissors Creatures Kata

## Problem Description

Create a genetic algorithm simulation to model a world inhabited by Rock, Paper, and Scissors creatures. Each creature belongs to one of three species: Rock, Paper, or Scissors. They compete against each other daily for survival and reproduction.

### Rules of the World

1. **Initial Population**: Start with 300 creatures, with an equal distribution of 100 Rocks, 100 Papers, and 100 Scissors.

2. **Daily Competition**:
  - Each day, creatures are randomly paired to compete.
  - Competitions are resolved as follows:
    - **Rock beats Scissors**
    - **Scissors beats Paper**
    - **Paper beats Rock**
    - In the case of a draw, both creatures are of the same type.

3. **Reproduction**:
  - **Winners**: The winning creature produces 2 offspring of the same type.
  - **Draws**: Each creature in a draw produces 1 offspring of the same type.
  - **Losers**: The losing creature produces no offspring.

4. **Lifecycle**:
  - All creatures die at the end of the day, whether they have reproduced or not.
  - Only offspring inhabit the world for the next day.

5. **Simulation Period**: Run the simulation for up to 1,000,000 days.

### Goals

- Simulate the population evolution over time.
- Display the population composition after 1,000 days, 10,000 days, and 1,000,000 days.

Your task is to implement the simulation following the rules above and observe how the populations evolve over the specified durations.