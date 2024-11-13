# Rock, Paper, Scissors

Create an evolutionary simulation to model the world of Rock, Paper, and Scissors.

## Problem Description

In evolutionary biology, scientists often use simple models to study how organisms with different traits might evolve over time.
These models are called _evolutionary simulations_, and can be used to illustrate how natural selection might operate for given traits.

Create an evolutionary simulation  to model a hypothetical world of Rock, Paper, and Scissors.


## Requirements and Constraints

### Input Specifications

Your solution should allow you to easily specify the initial population size, as well as the number of  days (generations) to simulate.

### Output Specifications

Your solution should display the population composition at the end of the simulation.


### Constraints

Implement your solution so that it can perform well with very large populations? Can you simulate 1,000,000 generations?

## Examples and Test Cases

If you run your solution with only 2 Rock and 2 Paper creatures (0 Scissors), you should have only Papers by the end of about 10 generations.

### Sample Inputs and Outputs

bash
ruby main.rb --population-size=100 --days=10000

Rocks: 12,312
Paper: 11,153
Scissors: 11,930


### Instructions

### Rock, Paper, Scissors World

Imagine a world inhabited by Rock, Paper, and Scissors creatures. Model the world based on the following rules, and print the population composition at the end of the simulation.

### Rules of the World

1. **Initial Population**: Start with 300 creatures, with an equal distribution of 100 Rocks, 100 Papers, and 100 Scissors.

2. **Daily Competition**:
- Each day, all creatures are randomly paired with another to compete.
- Competitions are resolved as follows:
    - **Rock beats Scissors**
    - **Scissors beats Paper**
    - **Paper beats Rock**
    - If both creatures are of the same type, they draw

3. **Reproduction**:
- **Winners**: The winning creature produces 2 offspring of the same type.
- **Draws**: Each creature in a draw produces 1 offspring of the same type.
- **Losers**: The losing creature produces no offspring.

4. **Lifecycle**:
- All creatures die at the end of the day, whether they have reproduced or not.
- Only offspring inhabit the world for the next day.

5. **Simulation Ends**:
- The simulation runs for a fixed number of days (generations) and then stops
- Once complete, the simulation prints the final population composition.


## Evaluation Criteria:

- Your can be configured to start with any initial population size, and any number of days (generations)
- Your model accurately simulates change in populations over time
- Your model prints the final population composition