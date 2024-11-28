# Generic falling block game solver!

Create a program that will play the falling-block game for you, so that you can hijack the high score board and impress all of your friends! 

## Problem Description

Imagine a hypothetical game where blocks of different shapes fall from the sky. 

Your job is to shift the blocks left and right so they fall into an optimal configuration.

If you complete a full row of blocks, those are eliminated and the playing plane is lowered. If you allow the blocks to stack up too high, you lose! 

Blocks can be in ane of of the following shapes:

### Square

```
▓▓▓▓ 
▓▓▓▓
```

### Line

```
▓▓ 
▓▓
▓▓
▓▓
```

### Z

```
▓▓▓▓
  ▓▓▓▓
```

### L

```
▓▓
▓▓
▓▓▓▓
```

Blocks may also have one or more orientations. Each orientation represents the shape turned 90 degrees clockwise. So the L block has 4 orientations:

```
# Orientation 1
  ▓▓
  ▓▓
  ▓▓▓▓
  
# Orientation 2  
  ▓▓▓▓▓▓
  ▓▓

# Orientation 3  
  ▓▓▓▓
    ▓▓
    ▓▓
    
# Orientation 4
      ▓▓
  ▓▓▓▓▓▓  
```

Unlike other popular, hypothetical falling block games, in our game players may choose which shape to play on each turn.

## Requirements and Constraints

### Input / Output Specifications

The input to your solution will be a string of text representing a game board. Note that, to improve the appearance of the grid, each cell in the grid is made up of two characters on one row. 

This means that the input will contain a string of 6 lines with 20 characters each, to give the appearance of a grid of 6x10 square cells (see tests below for examples).

The output of your solution will be a string of text representing the best shape to play, given the current state of the game board, and the orientation of the block to play. 

### Constraints

none 

## Examples and Test Cases

Your solution should include the following integration tests, and they should all pass:

```ruby
require 'minitest/autorun'

class GenericFallingBlocksGameTest < Minitest::Test
  def test_recommends_any_block_when_plane_is_level
    skip 'Not implemented'

    game_plane = <<~PLANE


      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    PLANE
    assert_equal 'Any', described_class.new(game_plane).recommended_block
    assert_equal :any, described_class.new(game_plane).recommended_orientation
  end

  def test_correctly_recommends_square_block_any_orientation
    skip 'Not implemented'

    game_plane = <<~PLANE


      ▓▓▓    ▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓    ▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    PLANE
    instance = described_class.new(game_plane)
    assert_equal 'Square', instance.recommended_block
    assert_equal :any, instance.recommended_orientation
  end

  def test_correctly_recommends_line_block_orientation_1
    skip 'Not implemented'

    game_plane = <<~PLANE


      ▓▓▓  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    PLANE
    instance = described_class.new(game_plane)
    assert_equal 'Line', instance.recommended_block
    assert_equal :orientation_1, instance.recommended_orientation
  end

  def test_correctly_recommends_line_block_orientation_2
    skip 'Not implemented'

    game_plane = <<~PLANE


      ▓▓▓▓▓▓▓▓▓▓        ▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    PLANE
    instance = described_class.new(game_plane)
    assert_equal 'Line', instance.recommended_block
    assert_equal :orientation_2, instance.recommended_orientation
  end

  def test_correctly_recommends_z_block_orientation_1
    skip 'Not implemented'

    game_plane = <<~PLANE


      ▓▓▓▓▓▓▓▓▓▓▓▓      ▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓    ▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    PLANE
    instance = described_class.new(game_plane)
    assert_equal 'Z', instance.recommended_block
    assert_equal :orientation_1, instance.recommended_orientation
  end

  def test_correctly_recommends_z_block_orientation_2
    skip 'Not implemented'

    game_plane = <<~PLANE


      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓    ▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓  ▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    PLANE
    instance = described_class.new(game_plane)
    assert_equal 'Z', instance.recommended_block
    assert_equal :orientation_2, instance.recommended_orientation
  end

  def test_correctly_recommends_l_orientation_1
    skip 'Not implemented'

    game_plane = <<~PLANE


      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓    ▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓    ▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓    ▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    PLANE
    instance = described_class.new(game_plane)
    assert_equal 'L', instance.recommended_block
    assert_equal :orientation_1, instance.recommended_orientation
  end

  def test_correctly_recommends_l_orientation_2
    skip 'Not implemented'

    game_plane = <<~PLANE


      ▓▓▓▓▓▓▓▓▓▓      ▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓  ▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    PLANE
    instance = described_class.new(game_plane)
    assert_equal 'L', instance.recommended_block
    assert_equal :orientation_2, instance.recommended_orientation
  end

  def test_correctly_recommends_l_orientation_3
    skip 'Not implemented'

    game_plane = <<~PLANE


      ▓▓▓▓▓▓▓▓    ▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓  ▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓  ▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    PLANE
    instance = described_class.new(game_plane)
    assert_equal 'L', instance.recommended_block
    assert_equal :orientation_3, instance.recommended_orientation
  end

  def test_correctly_recommends_l_orientation_4
    skip 'Not implemented'

    game_plane = <<~PLANE


      ▓▓▓▓▓▓▓▓      ▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    PLANE
    instance = described_class.new(game_plane)
    assert_equal 'L', instance.recommended_block
    assert_equal :orientation_4, instance.recommended_orientation
  end

  private

  def described_class
    # TODO: Define me!
  end
end
``` 

### Sample Inputs and Outputs

See passing tests above for samples.

### Instructions

1. Set up a test file with the above test cases, so that you are able to run all of the tests and see them pass/fail/skip. 
2. Write code that will solve the problem and pass the tests. 
3. Don't try to pass all of the tests at once, it's better to solve them one at a time (in the order they are listed above).
 
## Evaluation Criteria:

- All tests pass 

### Bonus criteria 

- Your solution is able to handle more complicated game boards and still produce reliable results.

### Mega bonus criteria 

(Don't worry if you don't get this far...)

- Your solution is able to handle new block shapes and will produce the most optimal solution based on all the available shapes. 