require_relative 'product'

class Brie < Product
  NAME = "Aged Brie".freeze
  MAX_QUALITY = 50
  DAILY_INCREASE = 2

  def tick
    @days_remaining = days_remaining - 1

    @quality = (quality + DAILY_INCREASE).clamp(0, MAX_QUALITY)
  end
end
