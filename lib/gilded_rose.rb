class GildedRoseItem
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

module UpdateItem
  def update_quality(item, amount, operator)
    item.quality = item.quality.send(operator, amount)
  end

  def update_days_remaining(item, amount, operator)
    item.days_remaining = item.days_remaining.send(operator, amount)
  end
end

module ValidateItem
  def is_50_or_greater_quality?(quality)
    quality >= 50
  end

  def is_less_than_50_quality?(quality)
    quality <  50
  end

  def is_equal_to_0_quality?(quality)
    quality == 0
  end

  def is_days_remaining_zero_or_greater?(days_remaining)
    days_remaining >= 0
  end

  def is_days_remaining_less_than_11?(days_remaining)
    days_remaining < 11
  end

  def is_days_remaining_less_than_6?(days_remaining)
    days_remaining < 6
  end
end

class AgedBrie
  include UpdateItem, ValidateItem

  def tick(item)
    update_days_remaining(item, 1, '-')

    return if is_50_or_greater_quality?(item.quality)

    update_quality(item, 1, '+')

    return if is_days_remaining_zero_or_greater?(item.days_remaining)

    return if is_50_or_greater_quality?(item.quality)

    update_quality(item, 1, '+')
  end
end

class BackstagePass
  include UpdateItem, ValidateItem

  def tick(item)
    if is_less_than_50_quality?(item.quality)

      update_quality(item, 1, '+')

      update_quality(item, 1, '+')  if is_days_remaining_less_than_11?(item.days_remaining)

      update_quality(item, 1, '+') if is_days_remaining_less_than_6?(item.days_remaining)
    end

    update_days_remaining(item, 1, '-')

    return if is_days_remaining_zero_or_greater?(item.days_remaining)

    update_quality(item, item.quality, '-')
  end
end

class ConjuredManaCake
  include UpdateItem, ValidateItem

  def tick(item)
    update_days_remaining(item, 1, '-')

    return if is_equal_to_0_quality?(item.quality)

    update_quality(item, 2, '-')

    update_quality(item, 2, '-') if item.days_remaining < 0
  end
end

class SulfurasHand
  def tick(item)
  end
end

class NormalItem
  include UpdateItem, ValidateItem

  def tick(item)
    update_days_remaining(item, 1, '-')

    return if is_equal_to_0_quality?(item.quality)

    update_quality(item, 1, '-')

    update_quality(item, 1, '-') if item.days_remaining < 0
  end
end

