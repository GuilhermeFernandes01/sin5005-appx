class Product < ApplicationRecord
  validates :name, presence: { message: "Name can't be blank" }
  validates :price, presence: { message: "Price can't be blank" }
  validates :category, presence: { message: "Category can't be blank" }
end
