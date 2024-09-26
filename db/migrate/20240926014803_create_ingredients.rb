class CreateIngredients < ActiveRecord::Migration[7.2]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.string :unityMeasure
      t.decimal :quantityStock

      t.timestamps
    end
  end
end
