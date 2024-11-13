#language: pt

Funcionalidade: Pedidos
  Como um cliente da pizzaria
  eu quero finalizar meu pedido colocando meu nome e os produtos que estão no carrinho
  de forma que eu possa ver o meu pedido com o meu nome, seus itens e o total na tela de pedidos

  Cenário: finalizar pedido
    Dado que possuo alguns produtos cadastrados:
      | name               | price   | category  |
      | Pizza de Pepperoni | 40.99   | Pizza     |
      | Água               | 1.99    | Bebidas   |
    E que possuo alguns itens no carrinho:
      | name               |
      | Pizza de Pepperoni |
      | Água               |
    E estou na página do carrinho
    Quando preencho o campo "Nome do cliente" com "José"
    E clico no botão "Finalizar Pedido"
    Então devo ter cadastrado o pedido no banco com meu nome "José" e com os produtos:
      | name               |
      | Pizza de Pepperoni |
      | Água               |
    E devo ver na página o pedido do "José" com os produtos:
      | name               |
      | Pizza de Pepperoni |
      | Água               |
    E o carrinho deve estar vazio

  Cenário: finalizar pedido sem nome
    Dado que possuo alguns produtos cadastrados:
      | name               | price   | category  |
      | Pizza de Pepperoni | 40.99   | Pizza     |
      | Água               | 1.99    | Bebidas   |
    E que possuo alguns itens no carrinho:
      | name               |
      | Pizza de Pepperoni |
      | Água               |
    E estou na página do carrinho
    Quando preencho o campo "Nome do cliente" com ""
    E clico no botão "Finalizar Pedido"
    Então devo ver a mensagem "Erro ao criar o pedido!"

  Cenário: deletar pedido
    Dado que possuo alguns produtos cadastrados:
      | name               | price   | category  |
      | Pizza de Pepperoni | 40.99   | Pizza     |
      | Água               | 1.99    | Bebidas   |
    E que possuo alguns pedidos cadastrados:
      | customer_name      | product_names            |
      | José               | Pizza de Pepperoni, Água |
    E estou na página de pedidos
    Quando clico no botão "Deletar" do pedido do "José" com os seguintes itens:
      | name               |
      | Pizza de Pepperoni |
      | Água               |
    Então não devo ver na página o pedido do "José" com os produtos:
      | name               |
      | Pizza de Pepperoni |
      | Água               |
    E devo ver a mensagem "Pedido foi deletado com sucesso!"
    E devo ver a mensagem "Não há pedidos cadastrados"

  Cenário: deletar 1 do vários pedidos
    Dado que possuo alguns produtos cadastrados:
      | name               | price   | category  |
      | Pizza de Pepperoni | 40.99   | Pizza     |
      | Água               | 1.99    | Bebidas   |
    E que possuo alguns pedidos cadastrados:
      | customer_name      | product_names            |
      | José               | Pizza de Pepperoni, Água |
      | Laura              | Pizza de Pepperoni       |
    E estou na página de pedidos
    Quando clico no botão "Deletar" do pedido do "José" com os seguintes itens:
      | name               |
      | Pizza de Pepperoni |
      | Água               |
    Então não devo ver na página o pedido do "José" com os produtos:
      | name               |
      | Pizza de Pepperoni |
      | Água               |
    E devo ver na página o pedido do "Laura" com os produtos:
      | name               |
      | Pizza de Pepperoni |
    E devo ver a mensagem "Pedido foi deletado com sucesso!"