require_relative 'main'
require 'minitest/autorun'

class ChristmasDayTest < Minitest::Test
  def test_returns_the_correct_weekday_for_2025
    skip 'Not implemented'
    assert_raises { ChristmasDay.new(2025).weekday }
  end

  def test_returns_the_correct_weekday_for_2024
    skip 'Not implemented'
    assert_equal 'Wednesday', ChristmasDay.new(2024).weekday
  end

  def test_returns_the_correct_weekday_for_2001
    skip 'Not implemented'
    assert_equal 'Tuesday', ChristmasDay.new(2001).weekday
  end

  def test_returns_the_correct_weekday_for_1900
    skip 'Not implemented'
    assert_equal 'Tuesday', ChristmasDay.new(1900).weekday
  end

  def test_returns_the_correct_weekday_for_1752
    skip 'Not implemented'
    assert_equal 'Monday', ChristmasDay.new(1752).weekday
  end

  def test_returns_the_correct_weekday_for_1751
    skip 'Not implemented'
    assert_equal 'Friday', ChristmasDay.new(1751).weekday
  end

  def test_returns_the_correct_weekday_for_1660
    skip 'Not implemented'
    assert_equal 'Wednesday', ChristmasDay.new(1660).weekday
  end

  def test_returns_the_correct_weekday_for_1659
    skip 'Not implemented'
    assert_raises { ChristmasDay.new(1659).weekday }
  end

  def test_returns_the_correct_weekday_for_1644
    skip 'Not implemented'
    assert_raises { ChristmasDay.new(1644).weekday }
  end

  def test_returns_the_correct_weekday_for_1643
    skip 'Not implemented'
    assert_equal 'Wednesday', ChristmasDay.new(1643).weekday
  end

  def test_returns_the_correct_weekday_for_1066
    skip 'Not implemented'
    assert_equal 'Wednesday', ChristmasDay.new(1066).weekday
  end

  def test_returns_the_correct_weekday_for_597
    skip 'Not implemented'
    assert_equal 'Friday', ChristmasDay.new(597).weekday
  end

  def test_returns_the_correct_weekday_for_596
    skip 'Not implemented'
    assert_raises { ChristmasDay.new(596).weekday }
  end
end
