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

    xit "raises an error if the quality is set to more than 50 on initialisation" do
      expect { Item.new("item", 50, 60) }.to raise_error
    end

    it "never sells Sulfuras" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 1, 80)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).not_to eq(0)
    end

    it "never decreases the quality of Sulfuras" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 1, 80)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).not_to be < 80
    end

    it "increases the quality of Backstage Passes as its SellIn value approaches" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 2, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to be > 0
    end

    it "increases the quality of Backstage Passes by 2 when there are 10 days or less before the concert" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 11)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(12)
    end

    it "increases the quality of Backstage Passes by 3 when there are 5 days or less before the concert" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 6, 11)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(13)
    end

    it "drops the quality of Backstage Passes to 0 after the concert" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 11)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq(0)
    end


  end

end
