#language: pt

Funcionalidade: Cadastro de Produtos
  Como um um funcionário da pizzaria
  eu quero consiguir cadastrar as informações (Nome, Preço, Categoria, Requer Ingrediente) de produtos
  de forma que eu possa ter um cadastro de produtos para criar um cardápio para os clientes

  Cenário: cadastro
    Dado que estou na página de cadastro de produto
    Quando preencho o campo nome "Nome do produto" com "Pizza de Pepperoni"
    E preencho o campo preço "Preço" com "40.00"
    E preencho o campo categoria "Categoria" com "Pizza"
    E seleciono o campo "Requer ingredientes"
    E clico no botão "Criar"
    Então devo ter cadastrado o produto ("Pizza de Pepperoni", 40.00, "Pizza", "true")