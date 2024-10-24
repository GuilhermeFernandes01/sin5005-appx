FactoryBot.define do
    factory :cliente do
      nome { "Nome Padrão" }
      telefone { "123456789" }
      email { "email@example.com" }
      endereco { "Endereço Padrão" }
      data_nascimento { "1990-01-01" }
    end
  end