
ActiveRecord::Schema[7.2].define(version: 2024_10_07_132238) do
  create_table "clientes", force: :cascade do |t|
    t.string "nome"
    t.string "telefone"
    t.string "email"
    t.string "endereco"
    t.text "observacoes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "data_nascimento"
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

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.string "unityMeasure"
    t.decimal "quantityStock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantityStockMin"
    t.integer "quantityStockMax"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.string "category"
    t.boolean "require_ingredients"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
