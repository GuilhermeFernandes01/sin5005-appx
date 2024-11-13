require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:pizza_product) { create(:product, :pizza_pepperoni) }
  let(:water) { create(:product, :water) }

  it "should not be valid if there is no customer name" do
    order = Order.new(customer_name: "")
    expect(order).to_not be_valid
    expect(order.errors[:customer_name]).to include "can't be empty"
  end

  it "should be valid if it has a customer name" do
    order = Order.new(customer_name: "José")
    expect(order).to be_valid
  end

  it "should calculate the total price properly" do
    order = Order.new(customer_name: "José")
    order.products << pizza_product
    order.products << water

    total_price = pizza_product.price + water.price

    expect(order.total_price).to equal(total_price)
  end
end
