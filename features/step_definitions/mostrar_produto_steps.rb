When('clico no link para ir para a página de produto da {string}') do |string|
  click_link(string)
end

Then('devo ver as informações do produto \({string}, {float}, {string}, {string})') do |name, price, category, require_ingredients|
  ingredients = require_ingredients == "true" ? "Sim" : "Não"

  expect(page).to have_content(name)
  expect(page).to have_content(price)
  expect(page).to have_content(category)
  expect(page).to have_content(ingredients)
end
