Given('que possuo alguns produtos cadastrados:') do |table|
  table.hashes.each do |product|
    Product.create!(product)
  end
end

Given('que os produtos possuem os seguintes ingredientes:') do |table|
  table.hashes.each do |product_ingredient|
    product = Product.find_by!(name: product_ingredient['product_name'])
    ingredient = Ingredient.find_by!(name: product_ingredient['ingredient_name'])

    product.ingredients << ingredient
  end
end

Given('estou na página de produtos') do
  visit '/products'
end

Then('devo ver esses produtos {string} e {string} listados') do |string, string2|
  expect(page).to have_selector("tr", text: string, count: 1)
  expect(page).to have_selector("tr", text: string2, count: 1)
end

Given('que não possuo produtos cadastrados') do
end

Then('devo ver a mensagem {string} sem a tabela') do |string|
  expect(page).to have_selector("table", count: 0)
  expect(page).to have_content(string)
end

Then('devo ver o produto {string} com {string} sendo {string}') do |product_name, column_name, column_value|
  within('table') do
    row = find('tr', text: product_name)

    column_index = find('thead tr').all('th').map(&:text).index(column_name)

    expect(row.all('td')[column_index].text).to eq(column_value)
  end
end
