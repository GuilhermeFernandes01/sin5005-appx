#language: pt

Funcionalidade: Listar Produtos
  Como um cliente da pizzaria
  eu quero poder ver todos os produtos cadastrados com suas informações (Nome, Preço, Categoria, Requer Ingrediente)
  de forma que eu possa saber quais produtos a pizzaria oferece para fazer o meu pedido

  Cenário: produtos existentes
    Dado que possuo alguns produtos cadastrados:
      | name               | price   | category  | require_ingredients |
      | Pizza de Pepperoni | 40.99   | Pizza     | true                |
      | Água               | 1.99    | Bebidas   | false               |
    E estou na página de produtos
    Então devo ver esses produtos "Pizza de Pepperoni" e "Água" listados

  Cenário: sem produtos
    Dado que não possuo produtos cadastrados
    E estou na página de produtos
    Então devo ver a mensagem "Não há produtos cadastrados" sem a tabela