#language: pt

Funcionalidade: Listar Produtos
  Como um cliente da pizzaria
  eu quero poder ver todos os produtos cadastrados com suas informações (Nome, Preço, Categoria, Requer Ingrediente)
  de forma que eu possa saber quais produtos a pizzaria oferece para fazer o meu pedido

  Cenário: produtos existentes
    Dado que possuo alguns ingredientes cadastrados:
      | name       | unityMeasure  | quantityStock  | quantityStockMin   | quantityStockMax   |
      | Queijo     | kg            | 10             | 20                 | 1000               |
      | Pepperoni  | unity         | 100            | 10                 | 1500               |
      | Tomate     | kg            | 25             | 30                 | 1800               |
    E que possuo alguns produtos cadastrados:
      | name               | price   | category  |
      | Pizza de Pepperoni | 40.99   | Pizza     |
      | Água               | 1.99    | Bebidas   |
    E que os produtos possuem os seguintes ingredientes:
      | product_name       | ingredient_name    |
      | Pizza de Pepperoni | Pepperoni          |
      | Pizza de Pepperoni | Queijo             |
    E estou na página de produtos
    Então devo ver esses produtos "Pizza de Pepperoni" e "Água" listados
    E devo ver o produto "Pizza de Pepperoni" com "Requer Ingredientes" sendo "true"
    E devo ver o produto "Água" com "Requer Ingredientes" sendo "false"

  Cenário: sem produtos
    Dado que não possuo produtos cadastrados
    E estou na página de produtos
    Então devo ver a mensagem "Não há produtos cadastrados" sem a tabela