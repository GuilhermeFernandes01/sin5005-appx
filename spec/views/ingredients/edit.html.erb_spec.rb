require 'rails_helper'

RSpec.describe "ingredients/edit", type: :view do
  let(:ingredient) {
    Ingredient.create!(
      name: "MyString",
      unityMeasure: "MyString",
      quantityStock: "9.99"
    )
  }

  before(:each) do
    assign(:ingredient, ingredient)
  end

  it "renders the edit ingredient form" do
    render

    assert_select "form[action=?][method=?]", ingredient_path(ingredient), "post" do

      assert_select "input[name=?]", "ingredient[name]"

      assert_select "input[name=?]", "ingredient[unityMeasure]"

      assert_select "input[name=?]", "ingredient[quantityStock]"
    end
  end
end
