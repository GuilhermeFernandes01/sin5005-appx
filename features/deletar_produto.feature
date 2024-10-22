#language: pt

Funcionalidade: Deletar Produto
  Como um funcionário da pizzaria
  eu quero consiguir deletar um produto
  de forma que eu possa remover produtos que não serão mais ofertados pela pizzaria

  Cenário: deletar produto
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
    E estou na página do produto "Pizza de Pepperoni"
    Quando clico no link para deletar o produto
    Então devo ver o produto "Água" e não o produto "Pizza de Pepperoni"