class CreateEmployees < ActiveRecord::Migration[7.2]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :salary
      t.string :position
      t.string :password_digest
      t.date :admission_date
      t.date :dismissal_date
      t.date :birth_date

      t.timestamps
    end
  end
end
