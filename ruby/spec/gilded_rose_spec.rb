require './lib/gilded_rose'

describe GildedRose do

  subject { described_class.new }
  vanilla_item = Item.new("vanilla item", 10, 5)
  item_of_zero_quality = Item.new("vanilla item", 10, 0)
  item_past_sell_in = Item.new("vanilla item", 0, 5)
  item_of_fifty_quality = Item.new("vanilla item", 5, 50)
  items = [vanilla_item, item_past_sell_in, item_of_fifty_quality, item_of_zero_quality]
  gilded_rose = GildedRose.new(items)

  vanilla_item_2 = Item.new("vanilla item", 10, 5)
  item_of_zero_quality_2 = Item.new("vanilla item", 10, 0)
  item_past_sell_in_2 = Item.new("vanilla item", 0, 5)
  item_of_fifty_quality_2 = Item.new("vanilla item", 5, 50)
  items = [vanilla_item_2, item_past_sell_in_2, item_of_fifty_quality_2, item_of_zero_quality_2]
  gilded_rose_2 = GildedRose.new(items)

  # describe "#update_quality" do
  #   it "does not change the name" do
  #     items = [Item.new("foo", 0, 0)]
  #     gilded_rose = GildedRose.new(items).update_quality()
  #     expect(items[0].name).to eq "fixme"
  #   end
  #   it 'is a test test' do
  #     puts "hello"
  #   end
  # end

  # describe "#adjust_quality" do
  #   it "lowers the quality of a vanilla item by 1 under normal circumastances" do
  #     expect{ gilded_rose.adjust_quality(vanilla_item) }.to change{vanilla_item.quality}.by -1
  #   end
  #   it "lowers the quality of a vanilla item by 2 when SellIn date has past" do
  #     expect{ gilded_rose.adjust_quality(item_past_sell_in) }.to change{item_past_sell_in.quality}.by -2
  #   end
  #   it "does not lowers the quality of a vanilla item that has alreadt reached zero quality" do
  #     expect{ gilded_rose.adjust_quality(item_of_zero_quality) }.to change{item_of_zero_quality.quality}.by 0
  #   end
  # end

  context 'applying logic the logic to multiple items' do
    describe 'quality of items' do
      it 'reduces the quality of a vanilla item of fifty quality and in SellIn date by 1' do
        expect{ gilded_rose_2.apply_quality_logic }.to change { item_of_fifty_quality_2.quality }.by -1
      end
      it 'reduces the quality of a vanilla item by 1 in sell in date' do
        expect{ gilded_rose_2.apply_quality_logic }.to change { vanilla_item_2.quality }.by -1
      end
      it 'reduces the quality of a vanilla item past SellIn date by 2' do
        expect{ gilded_rose_2.apply_quality_logic }.to change { item_past_sell_in_2.quality }.by -2
      end
      it 'reduces the quality of a vanilla item whose quality is zero by 0' do
        expect{ gilded_rose_2.apply_quality_logic }.to change { item_past_sell_in_2.quality }.by 0
      end
    end
  end


  describe 'reduce_sell_in_value' do
    it 'reduces the sell in value of an item' do
      expect { gilded_rose.reduce_sell_in_value }.to change{vanilla_item.sell_in}.by -1
    end
  end


  describe 'is_less_than_fifty_quality?' do
    it 'returns true if an item\'s quality is less than  fifty' do
      expect(gilded_rose.is_less_than_fifty_quality?(vanilla_item)).to eq true
    end
    it 'returns false if an item\'s quality is fifty or more' do
      # expect(gilded_rose.is_less_than_fifty_quality?(item_of_fifty_quality)).to eq false
    end
  end

  describe '#adjust_quality_of_vanilla_item' do
    it 'lowers the quality of an item by 1 under nromal circumastances' do
      expect { gilded_rose.adjust_quality_of_vanilla_item(vanilla_item) }.to change{vanilla_item.quality}.by -1
    end
    it 'lowers the quality of an item by 2 if the item is past sell in' do
      expect { gilded_rose.adjust_quality_of_vanilla_item(item_past_sell_in) }.to change{item_past_sell_in.quality}.by -2
    end
    it 'lowers the quality of an item by 0 if the item is of zero quality' do
      expect { gilded_rose.adjust_quality_of_vanilla_item(item_of_zero_quality) }.to change{item_of_zero_quality.quality}.by 0
    end
  end

  describe '#past_sell_in?' do
    it 'returns true for an item past its SellIn date' do
      expect(gilded_rose.past_sell_in?(vanilla_item)).to eq false
    end
    it 'returns true for an item past its SellIn date' do
      expect(gilded_rose.past_sell_in?(item_past_sell_in)).to eq true
    end
  end

  describe '#is_vanilla?' do
    it 'returns true for a truly vanilla item with no special attributes' do
      expect(gilded_rose.is_vanilla?(vanilla_item)).to eq true
    end
    it 'returns false for an item of zero quality' do
      expect(gilded_rose.is_vanilla?(item_of_zero_quality)).to eq false
    end
    it 'returns false for an item past SellIn date' do
      expect(gilded_rose.is_vanilla?(item_past_sell_in)).to eq false
    end
  end


end
