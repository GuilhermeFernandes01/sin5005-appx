require "rails_helper"

RSpec.describe "products/index.html.erb", type: :view do
  describe "with registered products" do
    let (:product1) { create(:product, :pizza_pepperoni) }
    let (:product2) { create(:product, :water) }

    before(:each) do
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
