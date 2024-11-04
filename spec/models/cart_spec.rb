require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:pizza_product) { create(:product, :pizza_pepperoni) }
  let(:water) { create(:product, :water) }

  it "should initialize the items array" do
    cart = Cart.new

    expect(cart.items).to match_array([])
  end

  it "should have a total price of 0 when the cart is empty" do
    cart = Cart.new

    expect(cart.total_price).to eq(0)
  end

  context "when the cart has items" do
    let(:cart) { Cart.new }

    before(:each) do
      cart.items << pizza_product
      cart.items << water
    end

    it "should have the products added" do
      expect(cart.items).to match_array([ pizza_product, water ])
    end

    it "should return the correct total price of the added products" do
      expect(cart.total_price).to eq(pizza_product.price + water.price)
    end
  end
end
