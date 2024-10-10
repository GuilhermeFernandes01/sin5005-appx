#language: pt

Funcionalidade: Mostrar Produto
  Como um cliente da pizzaria
  eu quero poder listar as informações de um produto (Nome, Preço, Categoria, Requer Ingrediente)
  de forma que eu possa decidir se quero comprá-lo

  Cenário: mostrar produto
    Dado que possuo alguns produtos cadastrados:
      | name               | price   | category  | require_ingredients |
      | Pizza de Pepperoni | 40.99   | Pizza     | true                |
      | Água               | 1.99    | Bebidas   | false               |
    E estou na página de produtos
    Quando clico no link para ir para a página de produto da "Pizza de Pepperoni"
    Então devo ver as informações do produto ("Pizza de Pepperoni", 40.99, "Pizza", "true")
