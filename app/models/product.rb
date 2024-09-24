class Product < ApplicationRecord
  validates :name, presence: { message: "can't be empty" }
  validates :price, presence: { message: "can't be empty" }, numericality: { greater_than: 0 }
  validates :category, presence: { message: "can't be empty" }
end
