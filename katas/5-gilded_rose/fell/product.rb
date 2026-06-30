class Product
  attr_reader :name, :quality, :days_remaining

  def initialize(name:, quality:, days_remaining:)
    @name = name
    @quality = quality
    @days_remaining = days_remaining
  end

  def tick
    if @quality > 0
      @quality = @quality - 1
    end

    @days_remaining = @days_remaining - 1

    if @days_remaining < 0
      if @quality > 0
        @quality = @quality - 1
      end
    end
  end
end
