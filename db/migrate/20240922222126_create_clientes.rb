class CreateClientes < ActiveRecord::Migration[7.2]
  def change
    create_table :clientes do |t|
      t.string :nome
      t.string :telefone
      t.string :email
      t.string :endereco
      t.text :observacoes

      t.timestamps
    end
  end
end
