class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    vendors.select do |vendor|
      vendor.inventory.has_key?(item)
    end
  end

  def sorted_item_list
    items = []
    vendors.each do |vendor|
      vendor.inventory.each_key do |item|
        items << item.name
      end
    end
    items.uniq.sort
  end

  def total_inventory
    inventory = Hash.new { |h, k| h[k] = { quantity: 0, vendors: [] } }
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        inventory[item][:quantity] += quantity
        inventory[item][:vendors] << vendor
      end
    end
    inventory
  end

  def overstocked_items
    overstocked_items = []
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        if quantity > 50 && vendors_that_sell(item).count > 1
          overstocked_items << item
        end
      end
    end
    overstocked_items.uniq
  end
end