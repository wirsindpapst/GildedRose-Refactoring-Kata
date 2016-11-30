class GildedRose

  attr_reader :items

  SPECIAL_ITEMS = [:aged_Brie, :sulfuras, :backstage_pass, :conjured_item]

  def initialize(items)
    @items = items
  end

  # Iterators

  def reduce_sell_in_value
    @items.each do |item|
      item.sell_in -= 1
    end
  end

  def update_quality
    @items.each do |item|
      apply_initial_routing(item)
    end
  end

  # 'Vanilla' item logic

  def apply_initial_routing(item)
    is_special_item?(item) ? (less_than_fifty_filter(item)) : ( adjust_quality_of_vanilla_item(item))
  end

  def adjust_quality_of_vanilla_item(item)
    is_vanilla?(item) ? (item.quality -= 1) : apply_past_sell_in_reduction_if_applicable(item)
  end

  def apply_past_sell_in_reduction_if_applicable(item)
    item.quality -= 2 if past_sell_in?(item) && !quality_is_zero?(item)
  end

  ##### Not sure this is right

  def less_than_fifty_filter(item)
    special_item_routing(item) if is_less_than_fifty_quality(item)
  end

  def more_than_zero_filter(item)
    less_than_fifty_filter(item) unless item.name == :conjured_item && quality_is_zero(item)
  end

  # ----------------------------

  # Special item logic

  def special_item_routing(item)
    case item.name
    when :aged_brie
      apply_aged_brie_quality_logic(item)
    when :backstage_pass
      apply_backstage_pass_quality_logic(item)
    when :conjured_item
      apply_conjured_item_quality_logic
    end
  end

  def apply_backstage_pass_quality_logic(item)
    if item.sell_in > 10
      item.quality +=1
    elsif item.sell_in > 5
      item.quality += 2
    elsif item.sell_in > 0
      item.quality += 3
    else
      item.quality = 0
    end
  end

  def apply_aged_brie_quality_logic(item)
    item.quality += 1
  end

  def apply_conjured_item_quality_logic(item)
    item.quality -= 2
  end

  # Predicate methods

  def is_special_item?(item)
    SPECIAL_ITEMS.include?(item.name)
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


# 
#   def update_quality()
#     @items.each do |item|
#       if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
#         if item.quality > 0
#           if item.name != "Sulfuras, Hand of Ragnaros"
#             item.quality = item.quality - 1
#           end
#         end
#       else
#         if item.quality < 50
#           item.quality = item.quality + 1
#           if item.name == "Backstage passes to a TAFKAL80ETC concert"
#             if item.sell_in < 11
#               if item.quality < 50
#                 item.quality = item.quality + 1
#               end
#             end
#             if item.sell_in < 6
#               if item.quality < 50
#                 item.quality = item.quality + 1
#               end
#             end
#           end
#         end
#       end
#       if item.name != "Sulfuras, Hand of Ragnaros"
#         item.sell_in = item.sell_in - 1
#       end
#       if item.sell_in < 0
#         if item.name != "Aged Brie"
#           if item.name != "Backstage passes to a TAFKAL80ETC concert"
#             if item.quality > 0
#               if item.name != "Sulfuras, Hand of Ragnaros"
#                 item.quality = item.quality - 1
#               end
#             end
#           else
#             item.quality = item.quality - item.quality
#           end
#         else
#           if item.quality < 50
#             item.quality = item.quality + 1
#           end
#         end
#       end
#     end
#   end
# end

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
