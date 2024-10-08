Given('estou na página do produto {string}') do |string|
  product = Product.find_by(name: string)

  visit "/products/#{product.id}"
end

When('clico no link para deletar o produto') do
  click_link('Deletar')
end

Then('devo ver o produto {string} e não o produto {string}') do |product1, product2|
  expect(page).to have_content(product1)
  expect(page).to have_no_content(product2)
end
