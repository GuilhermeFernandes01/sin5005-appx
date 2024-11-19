Given('que possuo alguns itens no carrinho:') do |table|
  table.hashes.each do |product|
    product_id = Product.find_by!(name: product[:name]).id

    visit "/products/#{product_id}"
    click_button('Adicionar ao Carrinho')
  end
end

Given('clico em {string}') do |string|
  click_button('Adicionar ao Carrinho')
end

Then('devo ver a mensagem {string}') do |message|
  expect(page).to have_content(message)
end

Then('devo ver o produto {string} no carrinho') do |product_name|
  product = Product.find_by!(name: product_name)

  expect(page).to have_content("#{product.name} - #{format_price(product.price)}")
end

Then('a sessão do carrinho deve conter o id do produto {string}') do |product_name|
  session = Capybara.current_session.driver.request.session
  product = Product.find_by!(name: product_name)

  expect(session[:cart]).to include(product.id)
end

Given('estou na página do carrinho') do
  visit '/cart'
end

When('clico para remover o produto {string}') do |product_name|
  within('li', text: product_name) do
    click_link 'Remover'
  end
end

Then('não devo ver o produto {string} no carrinho') do |product_name|
  product = Product.find_by!(name: product_name)

  expect(page).not_to have_content("#{product.name} - #{format_price(product.price)}")
end

Then('a sessão do carrinho não deve conter o id do produto {string}') do |product_name|
  session = Capybara.current_session.driver.request.session
  product = Product.find_by!(name: product_name)

  expect(session[:cart]).not_to include(product.id)
end

Então("devo ver o preço total do produto {string}") do |produto_nome|
  produto = Product.find_by(name: produto_nome)
  formatted_price = format_price(produto.price)
  expect(page).to have_content("#{produto_nome} - #{formatted_price}")
end

# frete

When('eu preencho o campo {string} com {string}') do |field_name, field_value|
  fill_in 'endereco', with: field_value
end

When('aperto o botão {string}') do |button_text|
  click_button(button_text)
end

Then('eu devo ver o valor do frete na página') do
  expect(page).to have_content("Valor do frete:")
end

Then(/^eu devo ver o total \(Produto \+ Frete\) na página$/) do
  expect(page).to have_content("Total (Produto + Frete):")
end

Then('eu devo ver uma mensagem de erro {string} na página do carrinho') do |mensagem_de_erro|
  expect(page).to have_content(mensagem_de_erro)
end

Then('eu devo ver uma mensagem de erro na página do carrinho') do
  expect(page).to have_css('.alert') # Verifica se há um elemento com classe CSS genérica de alerta
end
