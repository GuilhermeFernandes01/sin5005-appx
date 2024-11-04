#language: pt

Funcionalidade: Carrinho
  Como um cliente da pizzaria
  eu quero conseguir adicionar e remover produtos ao meu carrinho e ver o preço total
  de forma que eu possa ver o meu pedido

  Cenário: adicionar um produto ao carrinho
    Dado que possuo alguns produtos cadastrados:
      | name               | price   | category  |
      | Pizza de Pepperoni | 40.99   | Pizza     |
      | Água               | 1.99    | Bebidas   |
    E estou na página do produto "Pizza de Pepperoni"
    E clico em "Adicionar ao Carrinho"
    Então devo ver a mensagem "Pizza de Pepperoni foi adicionado ao carrinho."
    E devo ver o produto "Pizza de Pepperoni" no carrinho
    E a sessão do carrinho deve conter o id do produto "Pizza de Pepperoni"
    E devo ver o total dos produtos:
      | name               |
      | Pizza de Pepperoni |

  Cenário: remover o único produto do carrinho
    Dado que possuo alguns produtos cadastrados:
      | name               | price   | category  |
      | Pizza de Pepperoni | 40.99   | Pizza     |
      | Água               | 1.99    | Bebidas   |
    E que possuo alguns itens no carrinho:
      | name |
      | Água |
    E estou na página do carrinho
    Quando clico para remover o produto "Água"
    Então devo ver a mensagem "Água foi removido do carrinho."
    E não devo ver o produto "Água" no carrinho
    E a sessão do carrinho não deve conter o id do produto "Água"
    E devo ver a mensagem "Seu carrinho está vazio."

  Cenário: remover um dos vários produtos do carrinho
    Dado que possuo alguns produtos cadastrados:
      | name               | price   | category  |
      | Pizza de Pepperoni | 40.99   | Pizza     |
      | Água               | 1.99    | Bebidas   |
    E que possuo alguns itens no carrinho:
      | name               |
      | Água               |
      | Pizza de Pepperoni |
    E estou na página do carrinho
    Quando clico para remover o produto "Água"
    Então devo ver a mensagem "Água foi removido do carrinho."
    E não devo ver o produto "Água" no carrinho
    E a sessão do carrinho não deve conter o id do produto "Água"
    E devo ver o produto "Pizza de Pepperoni" no carrinho
    E a sessão do carrinho deve conter o id do produto "Pizza de Pepperoni"
    E devo ver o total dos produtos:
      | name               |
      | Pizza de Pepperoni |
    