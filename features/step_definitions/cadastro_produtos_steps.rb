Given('que possuo alguns ingredientes cadastrados:') do |table|
  table.hashes.each do |ingredient|
    Ingredient.create!(ingredient)
  end
end

Given('que estou na página de cadastro de produto') do
  visit '/products/new'
end

When('preencho o campo nome {string} com {string}') do |field, value|
  fill_in field, with: value
end

When('preencho o campo preço {string} com {string}') do |field, value|
  fill_in field, with: value
end

When('preencho o campo categoria {string} com {string}') do |field, value|
  fill_in field, with: value
end

When('seleciono os ingredientes:') do |table|
  table.hashes.each do |row|
    check row['Ingredient']
  end
end

When('clico no botão {string}') do |button|
  click_button button
end

Then('devo ter cadastrado o produto \({string}, {float}, {string}, {string})') do |name, price, category, require_ingredients|
  product = Product.find_by(name: name)

  expect(product).to_not be_nil
  expect(product.price).to eq(price)
  expect(product.category).to eq(category)
  expect(product.require_ingredients?).to eq(require_ingredients == "true")
end

When('preencho o formulário \({string}, {string}, {string}) com dados inválidos \({string}, {string}, {string})') do |name_field, price_field, category_field, name_value, price_value, category_value|
  fill_in name_field, with: name_value
  fill_in price_field, with: price_value
  fill_in category_field, with: category_value
end

Then('devo ver erros de cadastro do produto') do
  expect(page.status_code).to eq(422)

  expect(page).to have_content("Name can't be empty")
  expect(page).to have_content("Price can't be empty")
  expect(page).to have_content("Price is not a number")
  expect(page).to have_content("Category can't be empty")
end

Then('devo ver o erro de preço do produto') do
  expect(page.status_code).to eq(422)

  expect(page).to have_content("Price must be greater than 0")
end
