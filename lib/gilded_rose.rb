class ItemFactory
  def self.build(name)
    if name == "Aged Brie"
      AgedBrie.new
    elsif name == "Backstage passes to a TAFKAL80ETC concert"
      BackstagePass.new
    elsif name == "Conjured Mana Cake"
      ConjuredManaCake.new
    elsif name == "Sulfuras, Hand of Ragnaros"
      SulfurasHand.new
    else
      NormalItem.new
    end
  end
end

class AgedBrie
  def tick(degrade)
    if degrade.quality < 50
      degrade.quality += 1
    end

    degrade.days_remaining -= 1

    if degrade.days_remaining < 0
      if degrade.quality < 50
        degrade.quality += 1
      end
    end
  end
end

class BackstagePass
  def tick(degrade)
    if degrade.quality < 50

      degrade.quality += 1

      if degrade.days_remaining < 11
        degrade.quality += 1
      end

      if degrade.days_remaining < 6
        degrade.quality += 1
      end
    end

    degrade.days_remaining -= 1

    if degrade.days_remaining < 0
      degrade.quality -= degrade.quality
    end
  end
end

class ConjuredManaCake
  def tick(degrade)
    if degrade.quality > 0
      degrade.quality -= 2
    end

    degrade.days_remaining -= 1

    if degrade.days_remaining < 0
      if degrade.quality > 0
        degrade.quality -= 2
      end
    end
  end
end

class SulfurasHand
  def tick(degrade)
  end
end

class NormalItem
  def tick(degrade)
    if degrade.quality > 0
      degrade.quality -= 1
    end

    degrade.days_remaining -= 1

    if degrade.days_remaining < 0
      if degrade.quality > 0
        degrade.quality -= 1
      end
    end
  end
end

class GildedRose
  attr_accessor :name, :days_remaining, :quality

  def initialize(name:, days_remaining:, quality:)
    @name = name
    @days_remaining = days_remaining
    @quality = quality
  end

  def tick
    if @name == "Aged Brie"
      ItemFactory.build(name).tick(self)
    elsif @name == "Backstage passes to a TAFKAL80ETC concert"
      ItemFactory.build(name).tick(self)
    elsif @name == "Conjured Mana Cake"
      ItemFactory.build(name).tick(self)
    elsif @name == "Sulfuras, Hand of Ragnaros"
      ItemFactory.build(name).tick(self)
    else
      ItemFactory.build(name).tick(self)
    end
  end
end
