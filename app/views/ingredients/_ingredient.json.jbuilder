json.extract! ingredient, :id, :name, :unityMeasure, :quantityStock, :quantityStockMin, :quantityStockMax, :created_at, :updated_at
json.url ingredient_url(ingredient, format: :json)
