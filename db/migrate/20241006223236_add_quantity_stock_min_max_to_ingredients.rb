class AddQuantityStockMinMaxToIngredients < ActiveRecord::Migration[7.2]
  def change
    add_column :ingredients, :quantityStockMin, :integer
    add_column :ingredients, :quantityStockMax, :integer
  end
end
