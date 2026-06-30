# frozen_string_literal: true

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'

  gem 'minitest'
end

class GildedRose
  attr_reader :name, :days_remaining, :quality

  def initialize(name:, days_remaining:, quality:)
    @name = name
    @days_remaining = days_remaining
    @quality = quality
  end

  def to_h
    {name:, days_remaining:, quality:}
  end

  def tick
    # raise "Not implemented" if @name == "Aged Brie"
    return brie if @name == "Aged Brie"
    return sulfuras if @name == "Sulfuras, Hand of Ragnaros"
    return backstage if @name == "Backstage passes to a TAFKAL80ETC concert"
    return conjured if @name == "Conjured Mana Cake"

    if @name != "Aged Brie" and @name != "Backstage passes to a TAFKAL80ETC concert"
      if @quality > 0
        if @name != "Sulfuras, Hand of Ragnaros"
          @quality = @quality - 1
        end
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

    if @name != "Sulfuras, Hand of Ragnaros"
      @days_remaining = @days_remaining - 1
    end
    if @days_remaining < 0
      if @name != "Aged Brie"
        if @name != "Backstage passes to a TAFKAL80ETC concert"
          if @quality > 0
            if @name != "Sulfuras, Hand of Ragnaros"
              @quality = @quality - 1
            end
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

  def brie
    @quality = @quality + 1
    @quality = @quality + 1 if @days_remaining <= 0
    @quality = 50 if @quality > 50
      
    @days_remaining = @days_remaining - 1
  end

  def sulfuras
    # @quality = 80
    # @days_remaining = @days_remaining - 1
  end

  def backstage
    @quality = @quality + 1
    @quality = @quality + 1 if @days_remaining < 11
    @quality = @quality + 1 if @days_remaining < 6
    @quality = 0 if @days_remaining <= 0
    @quality = 50 if @quality > 50
    @days_remaining = @days_remaining - 1
  end

  def conjured
    @quality = @quality - 2
    @quality = @quality - 2 if @days_remaining <= 0
    @quality = 0 if @quality < 0
    @days_remaining = @days_remaining - 1
  end
end
