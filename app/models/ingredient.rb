class Ingredient < ApplicationRecord
  validates :name, presence: true
  validates :unityMeasure, presence: true
  validates :quantityStock, presence: true, numericality: { greater_than: 0 }
end
