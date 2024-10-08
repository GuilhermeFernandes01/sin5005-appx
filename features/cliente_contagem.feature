# language: pt

# features/contagem_de_clientes.feature

Funcionalidade: Contagem de Clientes

  Como um funcionário de pizzaria,
  Eu quero poder verificar a quantidade total de clientes cadastrados,
  Para garantir que todos os clientes estão sendo contabilizados corretamente.

  Cenário: Verificar a quantidade de clientes cadastrados
    Dado que existem clientes cadastrados
    Quando eu calculo o total de clientes
    E cadastro um novo cliente com nome "João Silva" e telefone "123456789"
    Então eu devo ver que o total de clientes é o total calculado anteriormente mais um.