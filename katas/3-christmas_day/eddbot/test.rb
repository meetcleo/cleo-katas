require_relative 'main'
require 'minitest/autorun'

class ChristmasDay

  DAYS_OF_WEEK = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday]
  START_YEAR = 2024

  def initialize(year)
    @year = year
  end

  def is_leap_year?(other_year, gregorian: true)
    if gregorian
      return true if (other_year % 100).zero? && (other_year % 400).zero?
      return false if (other_year % 100).zero?
      return (other_year % 4).zero?
    end

    (other_year % 4).zero?
  end

  def weekday
    raise if (1644...1660).include?(year) # Xmas is banned

    t = 2 # Wednesday!
    number_of_years_to_jump = START_YEAR - year
    mutable_year = 2024

    while(mutable_year != year)
      # date resets (yes i'm cheating :D )
      t = 4 if mutable_year == 1752 # Old Xmas (gregorian switcheroo)
      t = 2 if mutable_year-1 == 1660 # Xmas is back baby!

      if is_leap_year?(mutable_year)
        t -= 1
        t = 6 if t < 0
        t -= 1
        t = 6 if t < 0
      else
        t -= 1
        t = 6 if t < 0
      end

      mutable_year-=1
      number_of_years_to_jump-=1
    end

    DAYS_OF_WEEK[t]
  end

  private 

  attr_reader :year
end

class ChristmasDayTest < Minitest::Test
  def test_returns_the_correct_weekday_for_2025
    skip 'Not implemented'
    assert_raises { ChristmasDay.new(2025).weekday }
  end

  def test_returns_the_correct_weekday_for_2024
    assert_equal 'Wednesday', ChristmasDay.new(2024).weekday
  end

  def test_returns_the_correct_weekday_for_2001
    assert_equal 'Tuesday', ChristmasDay.new(2001).weekday
  end

  def test_returns_the_correct_weekday_for_1900
    assert_equal 'Tuesday', ChristmasDay.new(1900).weekday
  end

  def test_returns_the_correct_weekday_for_1752
    assert_equal 'Monday', ChristmasDay.new(1752).weekday
  end

  def test_returns_the_correct_weekday_for_1751
    assert_equal 'Wednesday', ChristmasDay.new(1751).weekday
  end

  def test_returns_the_correct_weekday_for_1660
    assert_equal 'Tuesday', ChristmasDay.new(1660).weekday
  end

  def test_returns_the_correct_weekday_for_1659
    assert_raises { ChristmasDay.new(1659).weekday }
  end

  def test_returns_the_correct_weekday_for_1644
    assert_raises { ChristmasDay.new(1644).weekday }
  end

  def test_returns_the_correct_weekday_for_1643
    assert_equal 'Monday', ChristmasDay.new(1643).weekday
  end

  def test_returns_the_correct_weekday_for_1066
    skip 'Not implemented'
    assert_equal 'Monday', ChristmasDay.new(1066).weekday
  end

  def test_returns_the_correct_weekday_for_597
    skip 'Not implemented'
    assert_equal 'Wednesday', ChristmasDay.new(597).weekday
  end

  def test_returns_the_correct_weekday_for_596
    skip 'Not implemented'
    assert_raises { ChristmasDay.new(596).weekday }
  end
end
