class RemoveRequireIngredientsFromProducts < ActiveRecord::Migration[7.2]
  def change
    remove_column :products, :require_ingredients, :boolean
  end
end
