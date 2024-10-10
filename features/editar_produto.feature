#language: pt

Funcionalidade: Editar Produto
  Como um funcionário da pizzaria
  eu quero consiguir editar os dados de um produto (Nome, Preço, Categoria, Requer Ingrediente)
  de forma que eu consiga atualizar os dados de um produto ofertado

  Cenário: editar um produto com dados válidos
    Dado que possuo alguns produtos cadastrados:
      | name               | price   | category  | require_ingredients |
      | Pizza de Pepperoni | 40.99   | Pizza     | true                |
    E estou na página do produto "Pizza de Pepperoni"
    Quando clico no botão editar
    E atualizo as informações do produto ("Nome do produto", "Preço", "Categoria", "Requer ingredientes") para ("Água", 1.99, "Bebidas", "false")
    E clico no botão "Salvar"
    Então devo ver as informações novas do produto ("Água", 1.99, "Bebidas", "false")

  Cenário: editar um produto com dados inválidos
    Dado que possuo alguns produtos cadastrados:
      | name               | price   | category  | require_ingredients |
      | Pizza de Pepperoni | 40.99   | Pizza     | true                |
    E estou na página do produto "Pizza de Pepperoni"
    Quando clico no botão editar
    E atualizo as informações do produto ("Nome do produto", "Preço", "Categoria", "Requer ingredientes") para ("", "", "", "false")
    E clico no botão "Salvar"
    Então devo ver os erros de edição de produto "Name can't be empty", "Price can't be empty", "Price is not a number", "Category can't be empty"

  Cenário: editar um produto com preço inválido
    Dado que possuo alguns produtos cadastrados:
      | name               | price   | category  | require_ingredients |
      | Pizza de Pepperoni | 40.99   | Pizza     | true                |
    E estou na página do produto "Pizza de Pepperoni"
    Quando clico no botão editar
    E atualizo as informações do produto ("Nome do produto", "Preço", "Categoria", "Requer ingredientes") para ("Água", 0.00, "Bebidas", "false")
    E clico no botão "Salvar"
    Então devo ver o erro de edição de produto "Price must be greater than 0"