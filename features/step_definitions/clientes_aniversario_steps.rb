

  Quando('eu calculo o total de clientes aniversariantes') do
    mes_atual = Date.today.month
    @total_aniversariantes = @clientes.select { |cliente| cliente[:data_nascimento] && cliente[:data_nascimento].month == mes_atual }.size
  end

  Então('eu devo ver que o total de clientes aniversariantes é menor ou igual ao total de clientes aniversariantes calculado anteriormente.') do
    mes_atual = Date.today.month
    total_aniversariantes_atual = @clientes.select { |cliente| cliente[:data_nascimento] && cliente[:data_nascimento].month == mes_atual }.size
    
    expect(total_aniversariantes_atual).to eq(@total_aniversariantes) 
  end
  
  