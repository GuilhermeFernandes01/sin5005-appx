require 'rails_helper'

RSpec.describe "products/show.html.erb", type: :view do
  let(:product1) { create(:product, :pizza_pepperoni) }
  let(:product2) { create(:product, :water) }

  describe "with a registered product" do
    it "should render the product1's informations" do
      assign(:product, product1)

      render

      expect(rendered).to have_selector("h1", text: "Pizza de Pepperoni")
      expect(rendered).to have_selector("p", text: "Preço: 39.99")
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
