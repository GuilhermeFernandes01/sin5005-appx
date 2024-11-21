require "rails_helper"

RSpec.describe "cart/index.html.erb", type: :view do
  include CardapioHelper
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
      expect(rendered).to have_selector("li", text: "#{product1.name} - #{format_price(product1.price)}")
      expect(rendered).to have_selector("li", text: "#{product2.name} - #{format_price(product2.price)}")
    end

    it "should display the total price" do
      render
      expect(rendered).to have_selector("h2", text: "Total: #{format_price(product1.price + product2.price)}")
    end
  end

  describe "freight calculation" do
    let(:freight_value) { 10.00 }

    before(:each) do
      assign(:cart, cart)
      cart.items << product1
      cart.items << product2
      # Simulando o valor do frete em flash
      flash[:freight_value] = freight_value
    end

    it "should display the freight value when calculated" do
      render

      expect(rendered).to have_selector("p", text: "Valor do frete: #{format_price(freight_value)}")
    end

    it "should display the total price including freight" do
      render

      total_price = product1.price + product2.price + freight_value
      expect(rendered).to have_selector("p", text: "Total (Produto + Frete): #{format_price(total_price)}")
    end

    it "should display the total price without freight before calculation" do
      render
      expect(rendered).to have_selector("h2", text: "Total: #{format_price(product1.price + product2.price)}")
    end
  end

  describe "when there's an error in freight calculation" do
    before(:each) do
      assign(:cart, cart)
      cart.items << product1
      cart.items << product2
      # Simulando uma falha no cálculo de frete
      flash[:alert] = "Erro ao calcular frete"
    end

    it "should display the error message if freight calculation fails" do
      render

      expect(rendered).to have_selector("p", text: "Erro ao calcular frete")
    end
  end
end
