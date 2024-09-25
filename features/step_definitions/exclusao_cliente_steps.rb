Dado("que eu estou na página de clientes") do
    visit clientes_path
  end

  Dado("eu tenho um cliente chamado {string}") do |nome_cliente|
    @cliente = Cliente.create!(nome: nome_cliente, telefone: "1234567890", email: "joao@example.com", endereco: "Rua A, 123", observacoes: "Cliente novo")
  end

  Quando("eu clicar no link {string} para o cliente {string}") do |link, nome_cliente|
    within('tr', text: nome_cliente) do
      click_link link
    end
  end

  Quando("eu confirmar a exclusão") do
    page.driver.browser.switch_to.alert.accept
  end

  Então("não deve aparecer mensagem alguma") do
    expect(page).not_to have_content("Cliente excluído com sucesso.")
    expect(page).not_to have_content("erro")
  end
