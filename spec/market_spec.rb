require './lib/item'
require './lib/vendor'
require './lib/market'
require 'date'


RSpec.describe Market do
  before(:each) do
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor3 = Vendor.new("Palisade Peach Shack")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: "$0.50"})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)

  end

  describe '#initialize' do
    it 'exists and has attributes' do
      expect(@market).to be_a(Market)
      expect(@market.name).to eq("South Pearl Street Farmers Market")
    end
  end

  describe '#vendors' do
    it 'starts out with an empty array for vendors' do
      expect(@market.vendors).to eq([])
    end

    it 'adds vendors' do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
    end

    it 'returns vendors names' do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      expect(@market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end
  end

  describe '#sell' do
    it 'it returns a list of vendors that have that item in stock' do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      expect(@market.vendors_that_sell(@item1)).to eq([@vendor1, @vendor3])
      expect(@market.vendors_that_sell(@item4)).to eq([@vendor2])
    end
  end

  describe '#potential value' do
    it 'can add the sum of all items prices * quantity' do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      expect(@vendor1.potential_revenue).to eq(29.75)
      expect(@vendor2.potential_revenue).to eq(345.00)
      expect(@vendor3.potential_revenue).to eq(48.75)
    end
  end

  describe '#sorted item list' do
    it 'can add names of items the Vendors have in stock into an array' do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      expect(@market.sorted_item_list).to be_an(Array)
      expect(@market.sorted_item_list).to eq(["Banana Nice Cream", 'Peach', "Peach-Raspberry Nice Cream", 'Tomato'])
    end
  end

  describe '#total inventory' do
   it 'can report the quantities of all items sold at the market' do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      expected = {
        @item1 => { quantity: 100, vendors: [@vendor1, @vendor3] },
        @item2 => { quantity: 7, vendors: [@vendor1] },
        @item3 => { quantity: 25, vendors: [@vendor2] },
        @item4 => { quantity: 50, vendors: [@vendor2] }
      }

      expect(@market.total_inventory).to be_a(Hash)
      expect(@market.total_inventory).to eq(expected)
    end
  end

  describe '#overstocked items' do
    it 'can return an array of items that are sold by multiple vendors and have a quantity > 50' do
      @market.add_vendor(@vendor1)
      @market.add_vendor(@vendor2)
      @market.add_vendor(@vendor3)

      expect(@market.overstocked_items).to be_an(Array)
      expect(@market.overstocked_items).to eq([@item1])
    end
  end

  describe '#date' do
    it 'returns the date in dd/mm/yyyy format' do
      past_date = Date.new(2022, 1, 1) 
      allow(Date).to receive(:today).and_return(past_date)
      
      expect(@market.date).to eq('01/01/2022')
                # expected: "01/01/2022"
                # got: "2022-01-01"
      # expect(@market.date.today).to eq("17/04/2023")
    end
  end
end