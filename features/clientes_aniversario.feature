# language: pt

# features/contagem_de_clientes.feature

Funcionalidade: Contagem de Clientes aniversariantes

  Como um funcionário de pizzaria,
  Eu quero poder verificar a quantidade total de clientes cadastrados aniversariantes no mês atual,
  Para que eu possa manter o relacionamento com o cliente por meio de ações promocionais ou comunicação de aniversário.

  Cenário: Verificar a quantidade de clientes aniversariantes cadastrados
    Dado que existem clientes cadastrados
    Quando eu calculo o total de clientes aniversariantes
    Então eu devo ver que o total de clientes aniversariantes é menor ou igual ao total de clientes aniversariantes calculado anteriormente.