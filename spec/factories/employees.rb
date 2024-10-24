FactoryBot.define do
  factory :employee do
    name { "John Doe" }
    salary { 50000 }
    position { "Developer" }
    password { "password" }
    password_confirmation { "password" }
    admission_date { "2020-01-01" }
    birth_date { "1990-01-01" }
    dismissal_date { nil }
  end
end
