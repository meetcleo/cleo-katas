# frozen_string_literal: true

require 'bundler/inline'
require_relative 'backstage_pass'
require_relative 'brie'
require_relative 'conjured_mana_cake'
require_relative 'sulfuras'

gemfile do
  source 'https://rubygems.org'

  gem 'minitest'
end

class GildedRose
  PRODUCTS = [BackstagePass, Brie, ConjuredManaCake, Sulfuras]

  attr_reader :product

  def initialize(name:, days_remaining:, quality:)
    @product = select_product(name:).new(name:, days_remaining:, quality:)
  end

  def select_product(name:)
    PRODUCTS.detect { |product_klass| product_klass::NAME == name } || Product
  end

  def tick
    product.tick
  end

  def days_remaining
    product.days_remaining
  end

  def name
    product.name
  end

  def quality
    product.quality
  end

  def to_h
    {name:, days_remaining:, quality:}
  end
end
