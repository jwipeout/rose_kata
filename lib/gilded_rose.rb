class GildedRose
  attr_reader :name, :days_remaining, :quality

  def initialize(name:, days_remaining:, quality:)
    @name = name
    @days_remaining = days_remaining
    @quality = quality
  end

  def tick
    if @name == "Aged Brie"
      if @quality < 50
        @quality = @quality + 1
      end

      @days_remaining = @days_remaining - 1

      if @days_remaining < 0
        if @quality < 50
          @quality = @quality + 1
        end
      end
    elsif @name == "Backstage passes to a TAFKAL80ETC concert"
      if @quality < 50

        @quality = @quality + 1

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

      @days_remaining = @days_remaining - 1

      if @days_remaining < 0
        @quality = @quality - @quality
      end
    elsif @name == "Sulfuras, Hand of Ragnaros"
    else
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
end
