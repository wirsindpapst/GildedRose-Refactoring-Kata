class GildedRose

  attr_reader :items

  SPECIAL_ITEMS = [:aged_Brie, :sulfuras, :backstage_pass, :conjured_item]

  def initialize(items)
    @items = items
  end

  def reduce_sell_in_value
    @items.each do |item|
      item.sell_in -= 1 
    end
  end

  def apply_quality_logic
    @items.each do |item|
      initial_routing(item)
    end
  end

  def initial_routing(item)
    adjust_quality_of_vanilla_item if is_less_than_fifty_quality(item)
  end

  def adjust_quality_of_vanilla_item(item)
    is_vanilla?(item) ? ( item.quality -= 1) : apply_past_sell_in_reduction_if_applicable(item)
  end

  def apply_past_sell_in_reduction_if_applicable(item)
    item.quality -= 2 if past_sell_in?(item) && !quality_is_zero?(item)
  end

  def is_less_than_fifty_quality?(item)
    item.quality < 50
  end

  def is_vanilla?(item)
    !quality_is_zero?(item) && !past_sell_in?(item)
  end

  def quality_is_zero?(item)
    item.quality <= 0
  end

  def past_sell_in?(item)
    item.sell_in <= 0
  end

  def items
    @items
  end



  def update_quality()
    @items.each do |item|
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > 0
          if item.name != "Sulfuras, Hand of Ragnaros"
            item.quality = item.quality - 1
          end
        end
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
          end
        end
      end
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in = item.sell_in - 1
      end
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              if item.name != "Sulfuras, Hand of Ragnaros"
                item.quality = item.quality - 1
              end
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
