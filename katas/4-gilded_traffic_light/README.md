# The Gilded Traffic Light

Refactor a messy legacy traffic light system into a proper domain model. 

You’ll start with a single-file procedural Ruby script that simulates an intersection with two directions of traffic lights and pedestrian signals. Your job is to gradually extract meaningful objects and ensure the behaviour doesn't change.

## Problem Description

Imagine a simplified but messy traffic controller. We have:

- Two directions of traffic (North-South and East-West).
- Each direction cycles through Red → Green → Amber → Red.
- Pedestrian signals can only display “WALK” when that direction is red. 

In the provided code, everything (timers, states, and transitions) is lumped into one file and one giant method. Refactor it into a more object-oriented design, preserving functionality.

## Requirements and Constraints

### Requirements

- The system should prevent conflicting green lights and only allow pedestrians to cross on red.
- The code must run forever unless interrupted.
- Do not break the existing console output or sequence logic.
- Preserve the timers for each colour transition.

### Constraints

- You must not remove or skip any stage of the light cycle (Red, Green, Amber).
- Keep the pedestrian signals tied to the traffic light states.

## Examples and Test Cases

A sample test file has been provided. Ensure these tests continue to pass as you refactor and rearrange the code.

## Instructions

Open the single-file Ruby script that contains the messy procedural code.
Run it directly to see the console output and confirm how the sequence changes over time.

Refactor the system one step at a time. Introduce appropriate classes to develop a deeper and more meaningful domain model, while preserving all the existing behaviour.

(Best to run the tests after each change to ensure everything still passes).

## Evaluation Criteria

- All tests pass for the final refactored solution.
- Quality of design: Classes and methods have clear responsibilities.
- Maintainability: Future changes (e.g. adding more directions or sensors) should be straightforward.
