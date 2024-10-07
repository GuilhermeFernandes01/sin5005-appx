require "rails_helper"

RSpec.describe "products/index.html.erb", type: :view do
  describe "with registered products" do
    before(:each) do
      mockedProducts = [
                          double('Product', name: 'Pizza de Pepperoni', price: 40.99, category: 'Pizzas', require_ingredients: true),
                          double('Product', name: 'Água', price: 1.99, category: 'Bebidas', require_ingredients: false)
                       ]
      assign(:products, mockedProducts)
    end

    it "should render the products properly" do
      render

      expect(rendered).to have_selector("tr", text: "Pizza de Pepperoni", count: 1)
      expect(rendered).to have_selector("tr", text: "Água", count: 1)
    end
  end

  describe "withouth registered products" do
    before(:each) do
      assign(:products, [])
    end

    it "should render the warning message withouth the table" do
      render

      expect(rendered).to have_selector("table", count: 0)
      expect(rendered).to include("Não há produtos cadastrados")
    end
  end
end
