Dado('que estou na página de cadastro de produto') do
  visit '/products/new'
end

Quando('preencho o campo nome {string} com {string}') do |field, value|
  fill_in field, with: value
end

Quando('preencho o campo preço {string} com {string}') do |field, value|
  fill_in field, with: value
end

Quando('preencho o campo categoria {string} com {string}') do |field, value|
  fill_in field, with: value
end

Quando('seleciono o campo {string}') do |field|
  check field
end

Quando('clico no botão {string}') do |button|
  click_button button
end

Então('devo ter cadastrado o produto \({string}, {float}, {string}, {string})') do |name, price, category, require_ingredients|
  product = Product.find_by(name: name)

  expect(product).to_not be_nil
  expect(product.price).to eq(price)
  expect(product.category).to eq(category)
  expect(product.require_ingredients).to eq(require_ingredients == "true")
end
