require 'gilded_rose.rb'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
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
    
  end

end
