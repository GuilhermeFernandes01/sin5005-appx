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

  expect(page).to have_content("#{product.name} - #{number_to_currency(product.price)}")
end

Then('a sessão do carrinho deve conter o id do produto {string}') do |product_name|
  session = Capybara.current_session.driver.request.session
  product = Product.find_by!(name: product_name)

  expect(session[:cart]).to include(product.id)
end

Then('devo ver o total dos produtos:') do |table|
  total = 0
  table.hashes.each do |product|
    total += Product.find_by!(name: product[:name]).price
  end

  expect(page).to have_content("Total: #{number_to_currency(total)}")
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

  expect(page).not_to have_content("#{product.name} - #{number_to_currency(product.price)}")
end

Then('a sessão do carrinho não deve conter o id do produto {string}') do |product_name|
  session = Capybara.current_session.driver.request.session
  product = Product.find_by!(name: product_name)

  expect(session[:cart]).not_to include(product.id)
end
