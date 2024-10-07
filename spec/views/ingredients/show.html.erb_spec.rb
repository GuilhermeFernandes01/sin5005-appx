require 'rails_helper'

RSpec.describe "ingredients/show", type: :view do
  before(:each) do
    assign(:ingredient, Ingredient.create!(
      name: "Name",
      unityMeasure: "Unity Measure",
      quantityStock: "9.99",
      quantityStockMin: "9.99",
      quantityStockMax: "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Unity Measure/)
    expect(rendered).to match(/9.99/)
  end
end
