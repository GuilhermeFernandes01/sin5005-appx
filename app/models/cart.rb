class Cart
  attr_accessor :items

  def initialize
    @items = []
  end

  def total_price
    items.sum(&:price)
  end
end
