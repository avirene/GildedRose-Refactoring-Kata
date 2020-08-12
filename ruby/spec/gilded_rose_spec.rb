require 'gilded_rose.rb'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("item", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "item"
    end

    it "lowers the quality of normal items" do
      items = [Item.new("normal item", 1, 1)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to be < 1
    end

    it "lowers the sell in of normal items" do
      items = [Item.new("normal item", 1, 1)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to be < 1
    end

    it "lowers the quality twice as fast after the sell by date has passed" do
      items = [Item.new("normal item", 0, 2)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(0)
    end

    it "never sets the quality to negative" do
      items = [Item.new("item", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to be >= 0
    end

    it "increases the quality of Aged Brie the older it gets" do
      items = [Item.new("Aged Brie", -5, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).not_to eq(0)
    end

    it "never sets the quality to more than 50" do
      items = [Item.new("item", 50, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to be <= 50
    end
  end

end
