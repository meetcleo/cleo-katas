class Product
  attr_reader :name, :quality, :days_remaining

  def initialize(name:, quality:, days_remaining:)
    @name = name
    @quality = quality
    @days_remaining = days_remaining
  end

  def tick
    if @name != "Aged Brie" and @name != "Backstage passes to a TAFKAL80ETC concert"
      if @quality > 0
        @quality = @quality - 1
      end
    else
      if @quality < 50
        @quality = @quality + 1
        if @name == "Backstage passes to a TAFKAL80ETC concert"
          if @days_remaining < 11
            if @quality < 50
              @quality = @quality + 1
            end
          end
          if @days_remaining < 6
            if @quality < 50
              @quality = @quality + 1
            end
          end
        end
      end
    end

    @days_remaining = @days_remaining - 1

    if @days_remaining < 0
      if @name != "Aged Brie"
        if @name != "Backstage passes to a TAFKAL80ETC concert"
          if @quality > 0
            @quality = @quality - 1
          end
        else
          @quality = @quality - @quality
        end
      else
        if @quality < 50
          @quality = @quality + 1
        end
      end
    end
  end
end
