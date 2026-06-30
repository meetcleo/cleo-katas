require_relative 'product'

class BackstagePass < Product
  NAME = "Backstage passes to a TAFKAL80ETC concert".freeze
  MAX_QUALITY = 50

  def tick
    increase = 1

    # TODO: Clean this up a bit more
    if days_remaining < 11
      increase = increase + 1
    end

    if days_remaining < 6
      increase = increase + 1
    end

    @quality = quality + increase

    @days_remaining = days_remaining - 1

    @quality = 0 if days_remaining.negative?

    @quality = (quality).clamp(0, MAX_QUALITY)
  end
end
