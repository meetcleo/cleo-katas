# traffic_light_system_test.rb

require_relative 'main'
require 'minitest/autorun'

class GildedRoseTest < Minitest::Test
  def test_before_sell_date
    gilded_rose = GildedRose.new(name: "Normal Item", days_remaining: 5, quality: 10)

    gilded_rose.tick

    assert_equal(
      {name: "Normal Item", days_remaining: 4, quality: 9},
      gilded_rose.to_h
    )
  end

  def test_on_sell_date
    gilded_rose = GildedRose.new(name: "Normal Item", days_remaining: 0, quality: 10)

    gilded_rose.tick

    assert_equal(
      {name: "Normal Item", days_remaining: -1, quality: 8},
      gilded_rose.to_h
    )
  end

  def test_after_sell_date
    gilded_rose = GildedRose.new(name: "Normal Item", days_remaining: -10, quality: 10)

    gilded_rose.tick

    assert_equal(
      {name: "Normal Item", days_remaining: -11, quality: 8},
      gilded_rose.to_h
    )
  end

  def test_of_zero_quality
    gilded_rose = GildedRose.new(name: "Normal Item", days_remaining: 5, quality: 0)

    gilded_rose.tick

    assert_equal(
      {name: "Normal Item", days_remaining: 4, quality: 0},
      gilded_rose.to_h
    )
  end
end

class AgedBrieTest < Minitest::Test
  def test_before_sell_date
    gilded_rose = GildedRose.new(name: "Aged Brie", days_remaining: 5, quality: 10)

    gilded_rose.tick

    assert_equal(
      {name: "Aged Brie", days_remaining: 4, quality: 11},
      gilded_rose.to_h
    )
  end

  def test_with_max_quality
    gilded_rose = GildedRose.new(name: "Aged Brie", days_remaining: 5, quality: 50)

    gilded_rose.tick

    assert_equal(
      {name: "Aged Brie", days_remaining: 4, quality: 50},
      gilded_rose.to_h
    )
  end

  def test_on_sell_date
    gilded_rose = GildedRose.new(name: "Aged Brie", days_remaining: 0, quality: 10)

    gilded_rose.tick

    assert_equal(
      {name: "Aged Brie", days_remaining: -1, quality: 12},
      gilded_rose.to_h
    )
  end

  def test_on_sell_date_near_max_quality
    gilded_rose = GildedRose.new(name: "Aged Brie", days_remaining: 0, quality: 49)

    gilded_rose.tick

    assert_equal(
      {name: "Aged Brie", days_remaining: -1, quality: 50},
      gilded_rose.to_h
    )
  end

  def test_on_sell_date_with_max_quality
    gilded_rose = GildedRose.new(name: "Aged Brie", days_remaining: 0, quality: 50)

    gilded_rose.tick

    assert_equal(
      {name: "Aged Brie", days_remaining: -1, quality: 50},
      gilded_rose.to_h
    )
  end

  def test_after_sell_date
    gilded_rose = GildedRose.new(name: "Aged Brie", days_remaining: -10, quality: 10)

    gilded_rose.tick

    assert_equal(
      {name: "Aged Brie", days_remaining: -11, quality: 12},
      gilded_rose.to_h
    )
  end

  def test_after_sell_date_with_max_quality
    gilded_rose = GildedRose.new(name: "Aged Brie", days_remaining: -10, quality: 50)

    gilded_rose.tick

    assert_equal(
      {name: "Aged Brie", days_remaining: -11, quality: 50},
      gilded_rose.to_h
    )
  end
end

class SulfurasTest < Minitest::Test
  def test_before_sell_date
    gilded_rose = GildedRose.new(name: "Sulfuras, Hand of Ragnaros", days_remaining: 5, quality: 80)

    gilded_rose.tick

    assert_equal(
      {name: "Sulfuras, Hand of Ragnaros", days_remaining: 5, quality: 80},
      gilded_rose.to_h
    )
  end

  def test_on_sell_date
    gilded_rose = GildedRose.new(name: "Sulfuras, Hand of Ragnaros", days_remaining: 0, quality: 80)

    gilded_rose.tick

    assert_equal(
      {name: "Sulfuras, Hand of Ragnaros", days_remaining: 0, quality: 80},
      gilded_rose.to_h
    )
  end

  def test_after_sell_date
    gilded_rose = GildedRose.new(name: "Sulfuras, Hand of Ragnaros", days_remaining: -10, quality: 80)

    gilded_rose.tick

    assert_equal(
      {name: "Sulfuras, Hand of Ragnaros", days_remaining: -10, quality: 80},
      gilded_rose.to_h
    )
  end
end

class BackstagePassTest < Minitest::Test
  def test_long_before_sell_date
    gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 11, quality: 10)

    gilded_rose.tick

    assert_equal(
      {name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 10, quality: 11},
      gilded_rose.to_h
    )
  end

  def test_long_before_sell_date_at_max_quality
    gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 11, quality: 50)

    gilded_rose.tick

    assert_equal(
      {name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 10, quality: 50},
      gilded_rose.to_h
    )
  end

  def test_medium_close_to_sell_date_upper_bound
    gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 10, quality: 10)

    gilded_rose.tick

    assert_equal(
      {name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 9, quality: 12},
      gilded_rose.to_h
    )
  end

  def test_medium_close_to_sell_date_upper_bound_at_max_quality
    gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 10, quality: 50)

    gilded_rose.tick

    assert_equal(
      {name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 9, quality: 50},
      gilded_rose.to_h
    )
  end

  def test_medium_close_to_sell_date_lower_bound
    gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 6, quality: 10)

    gilded_rose.tick

    assert_equal(
      {name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 5, quality: 12},
      gilded_rose.to_h
    )
  end

  def test_medium_close_to_sell_date_lower_bound_at_max_quality
    gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 6, quality: 50)

    gilded_rose.tick

    assert_equal(
      {name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 5, quality: 50},
      gilded_rose.to_h
    )
  end

  def test_very_close_to_sell_date_upper_bound
    gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 5, quality: 10)

    gilded_rose.tick

    assert_equal(
      {name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 4, quality: 13},
      gilded_rose.to_h
    )
  end

  def test_very_close_to_sell_date_upper_bound_at_max_quality
    gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 5, quality: 50)

    gilded_rose.tick

    assert_equal(
      {name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 4, quality: 50},
      gilded_rose.to_h
    )
  end

  def test_very_close_to_sell_date_lower_bound
    gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 1, quality: 10)

    gilded_rose.tick

    assert_equal(
      {name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 0, quality: 13},
      gilded_rose.to_h
    )
  end

  def test_very_close_to_sell_date_lower_bound_at_max_quantity
    gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 1, quality: 50)

    gilded_rose.tick

    assert_equal(
      {name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 0, quality: 50},
      gilded_rose.to_h
    )
  end

  def test_on_sell_date
    gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: 0, quality: 10)

    gilded_rose.tick

    assert_equal(
      {name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: -1, quality: 0},
      gilded_rose.to_h
    )
  end

  def test_after_sell_date
    gilded_rose = GildedRose.new(name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: -10, quality: 10)

    gilded_rose.tick

    assert_equal(
      {name: "Backstage passes to a TAFKAL80ETC concert", days_remaining: -11, quality: 0},
      gilded_rose.to_h
    )
  end
end

# class ConjuredManaCakeTest < Minitest::Test
#   def test_before_sell_date
#     skip "Not working"
#     gilded_rose = GildedRose.new(name: "Conjured Mana Cake", days_remaining: 5, quality: 10)

#     gilded_rose.tick

#     assert_equal(
#       {name: "Conjured Mana Cake", days_remaining: 4, quality: 8},
#       gilded_rose.to_h
#     )
#   end

#   def test_before_sell_date_at_zero_quality
#     gilded_rose = GildedRose.new(name: "Conjured Mana Cake", days_remaining: 5, quality: 0)

#     gilded_rose.tick

#     assert_equal(
#       {name: "Conjured Mana Cake", days_remaining: 4, quality: 0},
#       gilded_rose.to_h
#     )
#   end

#   def test_on_sell_date
#     skip "Not working"
#     gilded_rose = GildedRose.new(name: "Conjured Mana Cake", days_remaining: 0, quality: 10)

#     gilded_rose.tick

#     assert_equal(
#       {name: "Conjured Mana Cake", days_remaining: -1, quality: 6},
#       gilded_rose.to_h
#     )
#   end

#   def test_on_sell_date_at_zero_quality
#     gilded_rose = GildedRose.new(name: "Conjured Mana Cake", days_remaining: 0, quality: 0)

#     gilded_rose.tick

#     assert_equal(
#       {name: "Conjured Mana Cake", days_remaining: -1, quality: 0},
#       gilded_rose.to_h
#     )
#   end

#   def test_after_sell_date
#     gilded_rose = GildedRose.new(name: "Conjured Mana Cake", days_remaining: -10, quality: 10)

#     gilded_rose.tick

#     assert_equal(
#       {name: "Conjured Mana Cake", days_remaining: -11, quality: 6},
#       gilded_rose.to_h
#     )
#   end

#   def test_after_sell_date
#     gilded_rose = GildedRose.new(name: "Conjured Mana Cake", days_remaining: -10, quality: 0)

#     gilded_rose.tick

#     assert_equal(
#       {name: "Conjured Mana Cake", days_remaining: -11, quality: 0},
#       gilded_rose.to_h
#     )
#   end
# end
