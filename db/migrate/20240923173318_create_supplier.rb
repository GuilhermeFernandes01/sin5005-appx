class CreateSupplier < ActiveRecord::Migration[7.2]
  def change
    create_table :suppliers do |t|
      t.string :code
      t.string :name
      t.string :cnpj
      t.string :phone
      t.string :email
      t.string :segment
      t.string :products

      t.timestamps
    end
  end
end
