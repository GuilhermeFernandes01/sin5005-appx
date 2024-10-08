FactoryBot.define do
  factory :ingredient do
    name { "Tomate" }
    unityMeasure { "kg" }
    quantityStock { 1000 }
    quantityStockMin { 10 }
    quantityStockMax { 2000 }
  end
end
