require 'rails_helper'

RSpec.describe "products/show.html.erb", type: :view do
  let(:product1) { instance_double(Product, id: 1, name: "Pizza de Pepperoni", price: 40.99, category: "Pizza", require_ingredients: true) }
  let(:product2) { instance_double(Product, id: 2, name: "Água", price: 1.99, category: "Bebida", require_ingredients: false) }

  describe "with a registered product" do
    it "should render the product1's informations" do
      assign(:product, product1)

      render

      expect(rendered).to have_selector("h1", text: "Pizza de Pepperoni")
      expect(rendered).to have_selector("p", text: "Preço: 40.99")
      expect(rendered).to have_selector("p", text: "Categoria: Pizza")
      expect(rendered).to have_selector("p", text: "Requer ingredientes: Sim")
    end

    it "should render the product2's informations" do
      assign(:product, product2)

      render

      expect(rendered).to have_selector("h1", text: "Água")
      expect(rendered).to have_selector("p", text: "Preço: 1.99")
      expect(rendered).to have_selector("p", text: "Categoria: Bebida")
      expect(rendered).to have_selector("p", text: "Requer ingredientes: Não")
    end
  end
end
