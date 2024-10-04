FactoryBot.define do
  factory :ingredient do
    name { "Tomate" }
    unityMeasure { "kg" }
    quantityStock { 1000 }
  end
end
