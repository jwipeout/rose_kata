class GildedRose
  attr_accessor :name, :days_remaining, :quality

  def initialize(name:, days_remaining:, quality:)
    @name = name
    @days_remaining = days_remaining
    @quality = quality
  end

  def tick
    ItemFactory.build(name).tick(self)
  end
end

class ItemFactory
  def self.build(name)
    case name
    when 'Aged Brie'
      AgedBrie.new
    when 'Backstage passes to a TAFKAL80ETC concert'
      BackstagePass.new
    when 'Conjured Mana Cake'
      ConjuredManaCake.new
    when 'Sulfuras, Hand of Ragnaros'
      SulfurasHand.new
    else
      NormalItem.new
    end
  end
end

module UpdateGildedRose
  def update_quality(gilded_rose, amount, operator)
    gilded_rose.quality = gilded_rose.quality.send(operator, amount)
  end

  def update_days_remaining(gilded_rose, amount, operator)
    gilded_rose.days_remaining = gilded_rose.days_remaining.send(operator, amount)
  end
end

class AgedBrie
  include UpdateGildedRose

  def tick(gilded_rose)
    update_days_remaining(gilded_rose, 1, '-')

    return if gilded_rose.quality >= 50

    update_quality(gilded_rose, 1, '+')

    return if gilded_rose.days_remaining >= 0

    return if gilded_rose.quality >= 50

    update_quality(gilded_rose, 1, '+')
  end
end

class BackstagePass
  include UpdateGildedRose

  def tick(gilded_rose)
    if gilded_rose.quality < 50

      update_quality(gilded_rose, 1, '+')

      update_quality(gilded_rose, 1, '+')  if gilded_rose.days_remaining < 11

      update_quality(gilded_rose, 1, '+') if gilded_rose.days_remaining < 6
    end

    update_days_remaining(gilded_rose, 1, '-')

    return if gilded_rose.days_remaining >= 0

    update_quality(gilded_rose, gilded_rose.quality, '-')
  end
end

class ConjuredManaCake
  include UpdateGildedRose

  def tick(gilded_rose)
    update_days_remaining(gilded_rose, 1, '-')

    return if gilded_rose.quality == 0

    update_quality(gilded_rose, 2, '-')

    update_quality(gilded_rose, 2, '-') if gilded_rose.days_remaining < 0
  end
end

class SulfurasHand
  def tick(gilded_rose)
  end
end

class NormalItem
  include UpdateGildedRose

  def tick(gilded_rose)
    update_days_remaining(gilded_rose, 1, '-')

    return if gilded_rose.quality == 0

    update_quality(gilded_rose, 1, '-')

    update_quality(gilded_rose, 1, '-') if gilded_rose.days_remaining < 0
  end
end

