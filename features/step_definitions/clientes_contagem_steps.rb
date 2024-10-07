Dado('que existem clientes cadastrados') do
    @clientes = []
    @clientes << { nome: "Maria Silva", telefone: "987654321" }
    @clientes << { nome: "Carlos Oliveira", telefone: "123456789" }
  end
  
  Quando('eu calculo o total de clientes') do
    @total_antes = @clientes.size
  end
  
  Quando('cadastro um novo cliente com nome {string} e telefone {string}') do |nome, telefone|
    @clientes << { nome: nome, telefone: telefone }
  end
  
  Então('eu devo ver que o total de clientes é o total calculado anteriormente mais um.') do
    total_atual = @clientes.size
    expect(total_atual).to eq(@total_antes + 1)
  end
  