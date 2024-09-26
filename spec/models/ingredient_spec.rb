require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  it "is valid with valid attributes" do
    ingredient1 = Ingredient.new(name: "Leite", unityMeasure: "l", quantityStock: 10)
    expect(ingredient1).to be_valid

    ingredient2 = Ingredient.new(name: "Água", unityMeasure: "l", quantityStock: 100)
    expect(ingredient2).to be_valid
  end

  it "is invalid name can't be blank" do
    ingredient = Ingredient.new(name: "", unityMeasure: "l", quantityStock: 10)
    expect(ingredient).to_not be_valid
    expect(ingredient.errors[:name]).to include "can't be blank"
  end

  it "is invalid unityMeasure can't be blank " do
    ingredient = Ingredient.new(name: "Água", unityMeasure: "", quantityStock: 100)
    expect(ingredient).to_not be_valid
    expect(ingredient.errors[:unityMeasure]).to include "can't be blank"
  end

  it "is invalid quantityStock can't be blank" do
    ingredient = Ingredient.new(name: "Água", unityMeasure: "l", quantityStock: nil)
    expect(ingredient).to_not be_valid
    expect(ingredient.errors[:quantityStock]).to include "can't be blank"
  end

  it "is invalid unityMeasure and quantityStock can't be blank" do
    ingredient = Ingredient.new(name: "Água", unityMeasure: nil, quantityStock: nil)
    expect(ingredient).to_not be_valid
  end
end
