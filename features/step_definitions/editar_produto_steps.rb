Given('clico no botão editar') do
  click_button('Editar')
end

Given('atualizo as informações do produto \({string}, {string}, {string}) para \({string}, {float}, {string})') do |name_field, price_field, category_field, new_name, new_price, new_category|
  fill_in name_field, with: new_name
  fill_in price_field, with: new_price
  fill_in category_field, with: new_category
end

Then('devo ver as informações novas do produto \({string}, {float}, {string}, {string})') do |expected_name, expected_price, expected_category, expected_require_ingredients|
  expect(page).to have_content(expected_name)
  expect(page).to have_content(expected_price)
  expect(page).to have_content(expected_category)
  expect(page).to have_content(expected_require_ingredients == "true" ? "Sim" : "Não")
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
