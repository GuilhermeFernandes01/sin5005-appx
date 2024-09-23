class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.string :category
      t.boolean :require_ingredients

      t.timestamps
    end
  end
end
