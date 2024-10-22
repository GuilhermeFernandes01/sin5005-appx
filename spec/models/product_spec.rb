require 'rails_helper'

RSpec.describe Product, type: :model do
  it "is valid with valid attributes" do
    product1 = Product.new(name: "Pizza de Pepperoni", price: 40.99, category: "Pizza")
    expect(product1).to be_valid

    product2 = Product.new(name: "Água", price: 1.99, category: "Bebidas")
    expect(product2).to be_valid
  end

  it "is invalid without a name" do
    product = Product.new(price: 40.99, category: "Pizza")
    expect(product).to_not be_valid
    expect(product.errors[:name]).to include "can't be empty"
  end

  it "is invalid without a price" do
    product = Product.new(name: "Pizza de Pepperoni", category: "Pizza")
    expect(product).to_not be_valid
    expect(product.errors[:price]).to include "can't be empty"
  end

  it "is has an invalid price" do
    product = Product.new(name: "Pizza de Pepperoni", price: 0.00, category: "Pizza")
    expect(product).to_not be_valid
    expect(product.errors[:price]).to include "must be greater than 0"
  end

  it "is invalid without a category" do
    product = Product.new(name: "Pizza de Pepperoni", price: 40.99)
    expect(product).to_not be_valid
    expect(product.errors[:category]).to include "can't be empty"
  end

  describe "#require_ingredients?" do
    let!(:product) { create(:product) }
    let!(:ingredient) { create(:ingredient) }

    it "returns true if it has ingredients" do
      product.ingredients << ingredient

      expect(product.require_ingredients?).to be true
    end

    it "returns false if it has no ingredients" do
      expect(product.require_ingredients?).to be false
    end
  end
end
