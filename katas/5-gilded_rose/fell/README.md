# The Gilded Rose

Refactor a messy legacy product inventory system.

You’ll start with a single-file conditional Ruby class that provides
functionality for a product inventory system that tracks the days remaining and
quality of various products. Your job is to gradually extract meaningful objects
and ensure the behaviour doesn't change.

## Problem Description

You've arrived at a codebase in need. There's a legacy system that needs to keep
working, but on looking at the code, perhaps it's not quite up to your
standards. We need to keep the system working properly, whilst making it clearer
what functionality exists and how the various products behave. The system has a
single method, #tick, that represents moving forward one day in time, and this
changes attributes of a given product. The team has been struggling to add a new
product and its associated logic, and need your help.

## Requirements and Constraints

### Requirements

- Do not change any existing behaviour
- Handle all existing products
- Make adding new products easier, as this has been a challenge for the team

### Constraints

## Examples and Test Cases

A sample test file has been provided. Two tests for a new product the team needs
to add are skipped, because they don't work yet; the team needs your help to get
these tests passing.

## Instructions

Open the single-file Ruby script that contains the messy logic we are coupled to
for existing product logic.

Refactor the system one step at a time. Introduce appropriate classes and
methods to develop a deeper and more meaningful domain model, while preserving
all the existing behaviour.

(Best to run the tests after each change to ensure everything still passes).

## Evaluation Criteria

- All tests pass for the final refactored solution.
- No skipped or removed tests.
- Quality of design: Classes and methods have clear responsibilities.
- Maintainability: Future changes (e.g. adding more products) should be
  straightforward.


--- 

## How to run your main file 

```
bundle exec ruby katas/5-gilded_rose/fell/main.rb
```

