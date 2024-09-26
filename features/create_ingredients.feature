# language: pt

Funcionalidade: Gerenciar Ingredientes

  Como um funcionário da pizzaria
  eu quero poder ter um cadastro de ingredientes para controlar meu estoque. 
  O cadastro deve ter as seguintes informações: nome, unidade de medida e quantidade em estoque
  de forma que eu consiga cadastrar informações de ingredientes utilizados em pizzas e esfihas

  Cenário: Cadastrar um novo ingrediente
    Quando eu acesso a página de cadastro de ingredientes
    Então eu devo ver um formulário para cadastrar um novo ingrediente
    Quando eu preencho o formulário com:
      | Name | Unity Measure | Quantity Stock |
      | ---- | ------------- | -------------- |
      | Queijo | g | 1000 |
    E eu clico no botão "Criar"
    Então eu devo ser redirecionado para a página que mostra o ingrediente cadastrado
    E eu devo ver a mensagem de sucesso "Ingredient was successfully created."
    E eu devo ver o ingrediente "Queijo" na com a unidade "g" e a quantidade "1000"

  Cenário: Listar todos os ingredientes
    Dado que existem os seguintes ingredientes:
      | Name | Unity Measure | Quantity Stock |
      | Queijo | g | 1000 |
      | Tomate | un | 50 |
      | Massa | kg | 5 |
    Quando eu acesso a página de listagem de ingredientes
    Então eu devo ver uma lista com todos os ingredientes cadastrados

  Cenário: Editar um ingrediente
    Dado que existe o ingrediente "Queijo" com a unidade "g" e a quantidade "1000.0"
    Quando eu acesso a página de edição do ingrediente "Queijo"
    Então eu devo ver um formulário preenchido com os dados do ingrediente "Queijo"
    Quando eu altero a quantidade em estoque para "1500"
    E eu clico no botão "Update Ingredient"
    Então eu devo ser redirecionado para a página de ingrediente atualizado
    E eu devo visualizar a mensagem de sucesso " Ingredient was successfully updated."
    E eu devo visualizar o ingrediente "Queijo" com a unidade "g" e a quantidade "1500"
  
  Cenário: Remover um ingrediente
    Dado a existência do ingrediente "Tomate" com a unidade "un" e a quantidade "50"
    Quando eu acesso a página para exclusão do ingrediente "Tomate"
    E pressionado o botão "Destroy this ingredient"
    Então deve ser mostrada a mensagem de sucesso "Ingredient was successfully destroyed."
    E eu não devo ver o ingrediente "Tomate" na lista de ingredientes

