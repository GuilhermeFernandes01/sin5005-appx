# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.


ActiveRecord::Schema[7.2].define(version: 2024_09_23_173318) do
  create_table "clientes", force: :cascade do |t|
    t.string "nome"
    t.string "telefone"
    t.string "email"
    t.string "endereco"
    t.text "observacoes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.string "salary"
    t.string "position"
    t.string "password_digest"
    t.date "admission_date"
    t.date "dismissal_date"
    t.date "birth_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.string "category"
    t.boolean "require_ingredients"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "cnpj"
    t.string "phone"
    t.string "email"
    t.string "segment"
    t.string "products"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
