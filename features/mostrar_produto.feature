#language: pt

Funcionalidade: Mostrar Produto
  Como um cliente da pizzaria
  eu quero poder listar as informações de um produto (Nome, Preço, Categoria, Requer Ingrediente)
  de forma que eu possa decidir se quero comprá-lo

  Cenário: mostrar produto
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
    Quando clico no link para ir para a página de produto da "Pizza de Pepperoni"
    Então devo ver as informações do produto ("Pizza de Pepperoni", 40.99, "Pizza", "true")
