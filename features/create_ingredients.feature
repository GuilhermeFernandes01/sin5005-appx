# language: pt

# Iteração 1
Funcionalidade: Gerenciar Ingredientes

  Como um funcionário da pizzaria
  eu quero poder ter um cadastro de ingredientes para controlar meu estoque.
  O cadastro deve ter as seguintes informações: nome, unidade de medida e quantidade em estoque
  de forma que eu consiga cadastrar informações de ingredientes utilizados em pizzas e esfihas

  Como um funcionário da pizzaria  # Iteração 2 - Ingredientes - Quantidade Mínima e Máxima de Estoque
  eu quero controlar melhor o estoque de ingredientes. Sendo assim necessito que sejam acrescentadas a quantidade de estoque mínimo e a quantidade de estoque máximo.
  de forma que** eu consiga estabelecer uma melhor quantidade atual de estoque de ingredientes.

  Como um funcionário da pizzaria # Iteração 2 - Ingredientes - Visualização dos Ingredientes em Formato de Tabela
  eu quero poder visualizar os dados dos ingredientes (ID, Nome, Unidade de medição, Quantidade em estoque, Quantidade mínima em estoque,Quantidade máxima em estoque) na rota inicial de ingredientes em formato de tabela
  de forma que eu consiga ter uma melhor visualização dos ingredientes.

  Cenário: Cadastrar um novo ingrediente
    Quando eu acesso a página de cadastro de ingredientes
    Então eu devo ver um formulário para cadastrar um novo ingrediente
    Quando eu preencho o formulário com:
      | Nome | Unidade de medição | Quantidade em estoque | Quantidade mínima em estoque | Quantidade máxima em estoque |
      | ---- | ------------- | -------------- | ------------------ | ------------------ |
      | Queijo | g | 1000 | 10 | 2000 |
    E eu clico no botão "Criar"
    Então eu devo ser redirecionado para a página que mostra o ingrediente cadastrado
    Então eu devo ver a mensagem de sucesso "Ingrediente foi criado com sucesso."
    Então eu devo ver o ingrediente "Queijo" com a unidade "g" a quantidade "1000" a quantidade min "10" a quantidade max "2000"

  Cenário: Listar todos os ingredientes
    Dado que existem os seguintes ingredientes:
      | Nome | Unidade de medição | Quantidade em estoque | Quantidade mínima em estoque | Quantidade máxima em estoque |
      | Queijo | g | 1000 | 10 | 2000 |
      | Tomate | un | 50 | 10 | 500 |
      | Massa | kg | 1000 | 20 | 2000 |
    Quando eu acesso a página de listagem de ingredientes
    Então eu devo ver uma lista com todos os ingredientes cadastrados

  Cenário: Editar um ingrediente
    Dado que existe o ingrediente "Queijo" com a unidade "g" a quantidade "1000.0" a quantidade min "10" a quantidade max "2000"
    Quando eu acesso a página de edição do ingrediente "Queijo"
    Então eu devo ver um formulário preenchido com os dados do ingrediente "Queijo"
    Quando eu altero a quantidade em estoque para "1500"
    E eu clico no botão "Atualizar ingrediente"
    Então eu devo ser redirecionado para a página de ingrediente atualizado
    E eu devo visualizar a mensagem de sucesso "Ingrediente foi atualizado com sucesso."
    E eu devo visualizar o ingrediente "Queijo" com a unidade "g" a quantidade "1500" a quantidade min "10" a quantidade max "2000"

  Cenário: Remover um ingrediente
    Dado a existência do ingrediente "Tomate" com a unidade "un" a quantidade "50" a quantidade min "10" a quantidade max "2000"
    Quando eu acesso a página para exclusão do ingrediente "Tomate"
    E pressionado o botão "Destroy this ingredient"
    Então deve ser mostrada a mensagem de sucesso "Ingrediente foi excluído com sucesso."
    E eu não devo ver o ingrediente "Tomate" na lista de ingredientes
