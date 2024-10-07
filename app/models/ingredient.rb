class Ingredient < ApplicationRecord
  validates :name, presence: true
  validates :unityMeasure, presence: true
  validates :quantityStock, presence: true, numericality: { greater_than: 0 }
  validates :quantityStockMin, :quantityStockMax, presence: true, numericality: { only_integer: true }
  validate :validate_min_max_stock

  private

  def validate_min_max_stock
    if quantityStockMin && quantityStockMax && quantityStockMin > quantityStockMax
      errors.add(:quantityStockMin, "não pode ser maior que o estoque máximo")
    end
  end
end
