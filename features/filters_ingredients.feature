# language: pt

# Iteração 3
Funcionalidade: Ingredientes - Filtrar Cadastro Estoque/Estoque Min. 

  Como um funcionário da pizzaria
  eu quero controlar melhor o estoque de ingredientes. Sendo assim, desejo filtrar os ingredientes visualizando todos, 
    ou filtrando os ingredientes cuja quantityStock seja meno ou igual a quantityStock, 
    ou filtrando os ingredientes cuja a quantityStock seja maior que a quantityStockMin.
  de forma que eu consiga estabelecer uma melhor quantidade atual de estoque de ingredientes.

  Cenário: Visualizar todos os ingredientes
    Dado que eu acesso a página de ingredientes
    Então devem existir os seguintes ingredientes cadastrados:
      | Name   | Unity Measure | Quantity Stock | Quantity Stock Min | Quantity Stock Max |
      | Queijo | kg            | 10             | 20                 | 1000               |
      | Leite  | l             | 100            | 10                 | 1500               |
      | Tomate | kg            | 25             | 30                 | 1800               |
    Quando eu pressionar o botão "All Ingredients"
    Então eu devo continuar vendo todos os ingredientes listados

  Cenário: Filtrar ingredientes com estoque menor ou igual ao estoque mínimo
    Dado que continuo na página de ingredientes
    Então com os seguintes ingredientes cadastrados:
      | Name   | Unity Measure | Quantity Stock | Quantity Stock Min | Quantity Stock Max |
      | Queijo | kg            | 10             | 20                 | 1000               |
      | Leite  | l             | 100            | 10                 | 1500               |
      | Tomate | kg            | 25             | 30                 | 1800               |
    Quando eu clicar no botão "Less Than Stock Min" para filtrar
    Então devo ver os ingredientes "Queijo" e "Tomate"

  Cenário: Filtrar ingredientes com estoque maior que o estoque mínimo
    Dado que eu acesso a página de cadastro de ingredientes
    E vejo os ingredientes listados:
      | Name   | Unity Measure | Quantity Stock | Quantity Stock Min | Quantity Stock Max |
      | Queijo | kg            | 10             | 20                 | 1000               |
      | Leite  | l             | 100            | 10                 | 1500               |
      | Tomate | kg            | 25             | 30                 | 1800               |
    Quando eu filtrar pela opção "Greater Than Stock Min"
    Então devo ver o ingrediente "Leite"
