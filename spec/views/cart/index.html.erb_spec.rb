require "rails_helper"

RSpec.describe "cart/index.html.erb", type: :view do
  let(:cart) { Cart.new }
  let(:product1) { create(:product, :pizza_pepperoni) }
  let(:product2) { create(:product, :water) }

  describe "without products" do
    before(:each) do
      assign(:cart, cart)
      cart.items = []
    end

    it "should display the empty cart message" do
      render

      expect(rendered).to have_selector("p", text: "Seu carrinho está vazio.")
    end
  end

  describe "with products" do
    before(:each) do
      assign(:cart, cart)
      cart.items << product1
      cart.items << product2
    end

    it "should display the products" do
      render

      expect(rendered).to have_selector("li", text: "#{product1.name} - #{number_to_currency(product1.price)}")
      expect(rendered).to have_selector("li", text: "#{product2.name} - #{number_to_currency(product2.price)}")
    end

    it "should display the total price" do
      render

      expect(rendered).to have_selector("h2", text: "Total: #{number_to_currency(product1.price + product2.price)}")
    end
  end
end
