require './lib/vendor'
require './lib/item'

RSpec.describe Vendor do
  before(:each) do
    @vendor = Vendor.new("Rocky Mountain Fresh")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
  end

  describe '#initialize' do
    it 'exists and has attributes' do
      expect(@vendor).to be_a(Vendor)
      expect(@vendor.name).to eq("Rocky Mountain Fresh")
    end
  end

  describe '#inventory' do
    it 'starts with an empty hash for inventory' do
      expect(@vendor.inventory).to eq({})
    end

    it 'returns 0 for an items with no inventory' do
      expect(@vendor.check_stock(@item1)).to eq(0)
    end

    it 'can add stock to inventory' do
      @vendor.stock(@item1, 30)
      expect(@vendor.inventory).to eq({@item1 => 30})

      @vendor.stock(@item1, 25)
      expect(@vendor.inventory).to eq({@item1 => 55})

      @vendor.stock(@item2, 12)

      expect(@vendor.inventory).to eq({@item1 => 55, @item2 => 12})
    end

    it 'can check stock quantity' do
      @vendor.stock(@item1, 30)
      @vendor.stock(@item2, 12)

      expect(@vendor.check_stock(@item1)).to eq(30)
      expect(@vendor.check_stock(@item2)).to eq(12)
    end
  end
end