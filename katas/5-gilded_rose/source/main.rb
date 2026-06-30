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

  def tick_normal
    @days_remaining -= 1

    if @days_remaining > 0
      @quality -= 1
    else
      @quality -= 2
    end

    if @quality <=0
      @quality = 0
    end
  end

  def tick_brie
    if @days_remaining > 0
      @quality += 1
    else
      @quality += 2
    end

    if @quality >= 50
      @quality = 50
    end

    @days_remaining -= 1
  end

  def tick_sulfaras
  end

  def tick_backstage_passes
    if @days_remaining <= 0
      @quality = 0
    elsif @days_remaining <= 5
      @quality += 3
    elsif @days_remaining <= 10
      @quality += 2
      else
      @quality += 1
    end

    @days_remaining -=1
    @quality = @quality.clamp(0, 50)
  end

  def tick
    if @name == 'Normal Item'
      return tick_normal
    end

    if @name == 'Aged Brie'
      return tick_brie
    end

    if @name == 'Sulfuras, Hand of Ragnaros'
      return tick_sulfaras
    end

    if @name == 'Backstage passes to a TAFKAL80ETC concert'
      return tick_backstage_passes
    end

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
end
