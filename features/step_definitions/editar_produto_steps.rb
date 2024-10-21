Given('clico no botão editar') do
  click_button('Editar')
end

Given('atualizo as informações do produto \({string}, {string}, {string}) para \({string}, {float}, {string}) com os ingredientes:') do |name_field, price_field, category_field, new_name, new_price, new_category, ingredients|
  fill_in name_field, with: new_name
  fill_in price_field, with: new_price
  fill_in category_field, with: new_category

  # unckeck all ingredients
  all('input[type="checkbox"][name="ingredient_ids[]"]').each { |checkbox| uncheck checkbox[:id] }

  # check only the new configuration ingredients
  ingredients.hashes.each do |row|
    check row['Ingredient']
  end
end

Then('devo ver as informações novas do produto \({string}, {float}, {string}, {string})') do |expected_name, expected_price, expected_category, expected_require_ingredients|
  expect(page).to have_content(expected_name)
  expect(page).to have_content(expected_price)
  expect(page).to have_content(expected_category)
  expect(page).to have_content(expected_require_ingredients == "true" ? "Sim" : "Não")
end

Then('o produto {string} deve ter apenas os ingredientes:') do |product_name, ingredients|
  product = Product.find_by!(name: product_name)

  expected_ingredients = ingredients.hashes.map { |row| row['Ingredient'] }
  actual_ingredients = product.ingredients.map(&:name)

  expect(actual_ingredients).to match_array(expected_ingredients)
end

When('atualizo as informações do produto \({string}, {string}, {string}) para \({string}, {string}, {string})') do |name_field, price_field, category_field, new_name, new_price, new_category|
  fill_in name_field, with: new_name
  fill_in price_field, with: new_price
  fill_in category_field, with: new_category
end

Then('devo ver os erros de edição de produto {string}, {string}, {string}, {string}') do |error1, error2, error3, error4|
  expect(page).to have_content(error1)
  expect(page).to have_content(error2)
  expect(page).to have_content(error3)
  expect(page).to have_content(error4)
end

Then('devo ver o erro de edição de produto {string}') do |error|
  expect(page).to have_content(error)
end
