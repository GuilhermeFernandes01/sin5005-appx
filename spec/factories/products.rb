FactoryBot.define do
  factory :product do
    name { "Produto Exemplo" }
    price { 50.00 }
    category { "Exemplo" }

    trait :pizza_pepperoni do
      name { "Pizza de Pepperoni" }
      price { 39.99 }
      category { "Pizzas" }

      after(:create) do |pizza|
        cheese = create(:ingredient, :cheese)
        pepperoni = create(:ingredient, :pepperoni)

        pizza.ingredients << cheese
        pizza.ingredients << pepperoni
      end
    end

    trait :water do
      name { "Água" }
      price { 1.99 }
      category { "Bebidas" }
    end
  end
end
