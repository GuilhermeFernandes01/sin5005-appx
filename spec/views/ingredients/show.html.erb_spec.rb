require 'rails_helper'

RSpec.describe "ingredients/show", type: :view do
  before(:each) do
    assign(:ingredient, Ingredient.create!(
      name: "Nome",
      unityMeasure: "Unidade de medição",
      quantityStock: "9.99",
      quantityStockMin: "9.99",
      quantityStockMax: "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Nome/)
    expect(rendered).to match(/Unidade de medição/)
    expect(rendered).to match(/9.99/)
  end
end
