require "rails_helper"

RSpec.describe "products/index.html.erb", type: :view do
  describe "with registered products" do
    let (:product1) { instance_double(Product, id: 1, name: 'Pizza de Pepperoni', price: 40.99, category: 'Pizzas', require_ingredients: true) }
    let (:product2) { instance_double(Product, id: 2, name: 'Água', price: 1.99, category: 'Bebidas', require_ingredients: false) }

    before(:each) do
      allow(product1).to receive(:to_model).and_return(product1)
      allow(product1).to receive(:model_name).and_return(Product.model_name)
      allow(product1).to receive(:persisted?).and_return(true)

      allow(product2).to receive(:to_model).and_return(product2)
      allow(product2).to receive(:model_name).and_return(Product.model_name)
      allow(product2).to receive(:persisted?).and_return(true)

      mockedProducts = [
        product1,
        product2
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
