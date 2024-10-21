FactoryBot.define do
  factory :ingredient do
    name { "Tomate" }
    unityMeasure { "kg" }
    quantityStock { 1000 }
    quantityStockMin { 10 }
    quantityStockMax { 2000 }

    trait :pepperoni do
      name { "Pepperoni" }
      unityMeasure { "unity" }
      quantityStock { 100 }
      quantityStockMin { 50 }
      quantityStockMax { 200 }
    end

    trait :cheese do
      name { "Queijo" }
      unityMeasure { "kg" }
      quantityStock { 1000 }
      quantityStockMin { 200 }
      quantityStockMax { 2000 }
    end

    trait :tomato do
      name { "Tomate" }
      unityMeasure { "kg" }
      quantityStock { 1000 }
      quantityStockMin { 10 }
      quantityStockMax { 2000 }
    end
  end
end
