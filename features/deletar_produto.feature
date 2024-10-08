#language: pt

Funcionalidade: Deletar Produto
  Como um funcionário da pizzaria
  eu quero consiguir deletar um produto
  de forma que eu possa remover produtos que não serão mais ofertados pela pizzaria

  Cenário: deletar produto
    Dado que possuo alguns produtos cadastrados:
      | name               | price   | category  | require_ingredients |
      | Pizza de Pepperoni | 40.99   | Pizza     | true                |
      | Água               | 1.99    | Bebidas   | false               |
    E estou na página do produto "Pizza de Pepperoni"
    Quando clico no link para deletar o produto
    Então devo ver o produto "Água" e não o produto "Pizza de Pepperoni"