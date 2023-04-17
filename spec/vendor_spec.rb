require './lib/vendor'
require './lib/item'

RSpec.describe Vendor do
  before(:each) do
    @vendor = Vendor.new("Rocky Mountain Fresh")
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
      expect(@vendor.check_stock(item1)).to eq(0)
    end
  end
end