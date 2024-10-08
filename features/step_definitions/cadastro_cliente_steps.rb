Dado("que eu estou na página de clientes") do
    visit clientes_path
  end
  Quando("eu clicar no botão {string}") do |botao|
    click_link botao
  end
  Quando("eu preencher o formulário com os seguintes dados:") do |table|
    dados = table.rows_hash
    fill_in "Nome", with: dados["Nome"]
    fill_in "Telefone", with: dados["Telefone"]
    fill_in "Email", with: dados["Email"]
    fill_in "Endereço", with: dados["Endereço"]
    fill_in "Data_nascimento", with: dados["Data_nascimento"]
    fill_in "Observações", with: dados["Observações"]
  end
  Quando("eu clicar no botão {string}") do |botao|
    click_button botao
  end
  Então("eu devo ver a mensagem {string}") do |mensagem|
    expect(page).to have_content(mensagem)
  end
