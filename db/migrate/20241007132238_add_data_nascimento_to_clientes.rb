class AddDataNascimentoToClientes < ActiveRecord::Migration[7.2]
  def change
    add_column :clientes, :data_nascimento, :date
  end
end
