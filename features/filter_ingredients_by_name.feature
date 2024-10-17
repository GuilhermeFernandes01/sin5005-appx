# language: pt

# Iteração 3
Funcionalidade: Busca/Filtra Ingrediente por Nome

Como um funcionário de pizzaria,
eu quero procurar/filtrar o registro de um ingrediente usando o nome
de forma que eu possa verificar as informações cadastrais na tela de ingredientes.

  Cenário: Filtrar ingredientes
    Dado que estou na página de ingredientes
    Então existindo os seguintes ingredientes:
      | Name   | Unity Measure | Quantity Stock | Quantity Stock Min | Quantity Stock Max |
      | Queijo | kg            | 10             | 20                 | 1000               |
      | Leite  | l             | 100            | 10                 | 1500               |
      | Tomate | kg            | 25             | 30                 | 1800               |
    Quando eu preencher a caixa de texto "ingredient-name" com "Leite"
    Então pressionar o botão "Filter" para procurar ou filtrar
    Então devo ver somente o ingrediente "Leite"
     
