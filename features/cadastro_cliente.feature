
Feature: Cadastro de Cliente

  Cenário: Criar um novo cliente com sucesso
    Dado que eu estou na página de clientes
    Quando eu clicar no botão "Novo cadastro"
    E eu preencher o formulário com os seguintes dados:
      | Nome         | Telefone      | Email              | Endereço          | Observações          |
      | João Silva   | 1234567890    | joao@example.com   | Rua A, 123       | Cliente novo         |
    E eu clicar no botão "Salvar"
    Então eu devo ver a mensagem "Cliente criado com sucesso."
