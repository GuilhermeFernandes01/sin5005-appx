#language: pt

Funcionalidade: Cadastro de Produtos
  Como um um funcionário da pizzaria
  eu quero consiguir cadastrar as informações (Nome, Preço, Categoria) de produtos junto com o ingrediente que aquele produto usa
  de forma que eu possa ter um cadastro de produtos para criar um cardápio para os clientes

  Cenário: cadastro válido
    Dado que possuo alguns ingredientes cadastrados:
      | name       | unityMeasure  | quantityStock  | quantityStockMin   | quantityStockMax   |
      | Queijo     | kg            | 10             | 20                 | 1000               |
      | Pepperoni  | unity         | 100            | 10                 | 1500               |
      | Tomate     | kg            | 25             | 30                 | 1800               |
    E que estou na página de cadastro de produto
    Quando preencho o campo nome "Nome do produto" com "Pizza de Pepperoni"
    E preencho o campo preço "Preço" com "40.00"
    E preencho o campo categoria "Categoria" com "Pizza"
    E seleciono os ingredientes:
      | Ingredient |
      | Pepperoni  |
      | Queijo     |
    E clico no botão "Criar"
    Então devo ter cadastrado o produto ("Pizza de Pepperoni", 40.00, "Pizza", "true") com os ingredientes:
      | Ingredient |
      | Pepperoni  |
      | Queijo     |

  Cenário: cadastro válido sem ingredientes
    Dado que possuo alguns ingredientes cadastrados:
      | name       | unityMeasure  | quantityStock  | quantityStockMin   | quantityStockMax   |
      | Queijo     | kg            | 10             | 20                 | 1000               |
      | Pepperoni  | unity         | 100            | 10                 | 1500               |
      | Tomate     | kg            | 25             | 30                 | 1800               |
    E que estou na página de cadastro de produto
    Quando preencho o campo nome "Nome do produto" com "Água"
    E preencho o campo preço "Preço" com "1.99"
    E preencho o campo categoria "Categoria" com "Bebidas"
    E clico no botão "Criar"
    Então devo ter cadastrado o produto ("Água", 1.99, "Bebidas", "false") com os ingredientes:
      | Ingredient |

  Cenário: cadastro inválido
    Dado que estou na página de cadastro de produto
    Quando preencho o formulário ("Nome do produto", "Preço", "Categoria") com dados inválidos ("", "", "")
    E clico no botão "Criar"
    Então devo ver erros de cadastro do produto

  Cenário: cadastro com preço inválido
    Dado que estou na página de cadastro de produto
    Quando preencho o formulário ("Nome do produto", "Preço", "Categoria") com dados inválidos ("Pizza de Pepperoni", "0.00", "Pizza")
    E clico no botão "Criar"
    Então devo ver o erro de preço do produto