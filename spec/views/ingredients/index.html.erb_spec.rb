require 'rails_helper'

RSpec.describe "ingredients/index", type: :view do
  before(:each) do
    assign(:ingredients, [
      Ingredient.create!(
        name: "Name",
        unityMeasure: "Unity Measure",
        quantityStock: "9.99",
        quantityStockMin: "9.99",
        quantityStockMax: "9.99"
      ),
      Ingredient.create!(
        name: "Name",
        unityMeasure: "Unity Measure",
        quantityStock: "9.99",
        quantityStockMin: "9.99",
        quantityStockMax: "9.99"
      )
    ])
  end

  it "renders a list of ingredients" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Unity Measure".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
  end
end
