# language: pt

# Iteração 4
Funcionalidade: Menu do Aplicativo

  Como um funcionário da pizzaria
  Quero poder navegar através de um menu do tipo "dropdown"
  Para acessar as páginas Home, Clientes, Fornecedores, Empregados, Ingredientes e Produtos
  E ter uma melhor experiência de navegação no sistema.

  Cenário: Exibir o menu drop-down na barra de navegação
    Dado que estou na página inicial do sistema
    Quando vejo o menu drop-down de navegação
    Então devo ver as opções "Each Pizzas", "Clientes", "Fornecedores", "Empregados", "Ingredientes" e "Produtos"

