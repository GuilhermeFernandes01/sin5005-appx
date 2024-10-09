# language: pt

# Iteração 3
Funcionalidade: Ingredientes - Filtrar Cadastro Estoque/Estoque Min. 

  Como um funcionário da pizzaria
  eu quero controlar melhor o estoque de ingredientes. Sendo assim, desejo filtrar os ingredientes visualizando todos, 
    ou filtrando os ingredientes cuja quantityStock seja meno ou igual a quantityStock, 
    ou filtrando os ingredientes cuja a quantityStock seja maior que a quantityStockMin.
  de forma que eu consiga estabelecer uma melhor quantidade atual de estoque de ingredientes.

  Cenário: Visualizar todos os ingredientes
    Dado que eu acesso a página de cadastro de ingredientes
    Então devo ver os ingredientes listados:
      | Nome   | Unidade de Medida | Estoque | Estoque Mínimo | Estoque Máximo |
      | ------ | ----------------- | ------- | -------------- | -------------- |
      | Queijo | kg                | 10      | 20             | 1000           |
      | Leite  | l                 | 100     | 10             | 1500           |
      | Tomate | kg                | 25      | 30             | 1800           |
    Quando eu pressionar o botão "All Ingredients"
    Então devo continuar vendo todos os ingredientes listados

  Cenário: Filtrar ingredientes com estoque menor ou igual ao estoque mínimo
    Dado que eu acesso a página de cadastro de ingredientes
    E vejo os ingredientes listados:
      | Nome   | Unidade de Medida | Estoque | Estoque Mínimo | Estoque Máximo |
      | ------ | ----------------- | ------- | -------------- | -------------- |
      | Queijo | kg                | 10      | 20             | 1000           |
      | Leite  | l                 | 100     | 10             | 1500           |
      | Tomate | kg                | 25      | 30             | 1800           |
    Quando eu pressionar o botão "Less Than Stock Min."
    Então devo ver os ingredientes "Queijo" e "Tomate"

  Cenário: Filtrar ingredientes com estoque maior que o estoque mínimo
    Dado que eu acesso a página de cadastro de ingredientes
    E vejo os ingredientes listados:
      | Nome   | Unidade de Medida | Estoque | Estoque Mínimo | Estoque Máximo |
      | ------ | ----------------- | ------- | -------------- | -------------- |
      | Queijo | kg                | 10      | 20             | 1000           |
      | Leite  | l                 | 100     | 10             | 1500           |
      | Tomate | kg                | 25      | 30             | 1800           |
    Quando eu pressionar o botão "Greater Than Stock Min."
    Então devo ver o ingrediente "Leite"
