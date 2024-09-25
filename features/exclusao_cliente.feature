Feature: Exclusão de Cliente

  Cenário: Excluir um cliente com sucesso
    Dado que eu estou na página de clientes
    E eu tenho um cliente chamado "João Silva"
    Quando eu clicar no link "Excluir" para o cliente "João Silva"
    E eu confirmar a exclusão
    Então não deve aparecer mensagem alguma
