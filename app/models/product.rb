class Product < ApplicationRecord
  validates :name, presence: { message: "can't be empty" }
  validates :price, presence: { message: "can't be empty" }, numericality: { greater_than: 0 }
  validates :category, presence: { message: "can't be empty" }

  has_and_belongs_to_many :ingredients

  def require_ingredients?
    return ingredients.any?
  end
end
