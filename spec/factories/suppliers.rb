
FactoryBot.define do
  factory :supplier do
    name { "Supplier Name" }
    cnpj { "12345678000199" }
    phone { "(11) 99999-9999" }
    email { "supplier@example.com" }
    segment { "Supplier Segment" }
    products { "Supplier Products" }
  end
end
