require 'rails_helper'

RSpec.describe Product, type: :model do
  it "is valid with valid attributes" do
    product1 = Product.new(name: "Pizza de Pepperoni", price: 40.99, category: "Pizza", require_ingredients: true)
    expect(product1).to be_valid

    product2 = Product.new(name: "Água", price: 1.99, category: "Bebidas", require_ingredients: false)
    expect(product2).to be_valid
  end

  it "is invalid without a name" do
    product = Product.new(price: 40.99, category: "Pizza", require_ingredients: true)
    expect(product).to_not be_valid
    expect(product.errors[:name]).to include "Name can't be blank"
  end

  it "is invalid without a price" do
    product = Product.new(name: "Pizza de Pepperoni", category: "Pizza", require_ingredients: true)
    expect(product).to_not be_valid
    expect(product.errors[:price]).to include "Price can't be blank"
  end

  it "is invalid without a category" do
    product = Product.new(name: "Pizza de Pepperoni", price: 40.99, require_ingredients: true)
    expect(product).to_not be_valid
    expect(product.errors[:category]).to include "Category can't be blank"
  end
end
