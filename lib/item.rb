class Item
  attr_reader :name, 
              :price

  def initialize(attributes)
    @name = attributes[:name]
    @price = attributes[:price].gsub("$", "").to_f

  end
end