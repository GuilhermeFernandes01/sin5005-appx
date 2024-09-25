# language: pt

Funcionalidade: Gerenciar Ingredientes

  Como um funcionário da pizzaria
  eu quero poder ter um cadastro de ingredientes para controlar meu estoque. 
  O cadastro deve ter as seguintes informações: nome, unidade de medida e quantidade em estoque
  de forma que eu consiga cadastrar informações de ingredientes utilizados em pizzas e esfihas

  Cenário: Cadastrar um novo ingrediente
    Quando eu acesso a página de cadastro de ingredientes
    Então eu devo ver um formulário para cadastrar um novo ingrediente
#    Quando eu preencho o formulário com:
#      | Nome | Unidade de Medida | Quantidade em Estoque |
#      | ---- | ----------------- | --------------------- |
#      | Queijo | g | 1000 |
#    E eu clico no botão "Criar"
#    Então eu devo ser redirecionado para a página de listagem de ingredientes
#    E eu devo ver a mensagem de sucesso "Ingrediente cadastrado com sucesso!"
#    E eu devo ver o ingrediente "Queijo" na lista com a unidade "g" e a quantidade "1000"
