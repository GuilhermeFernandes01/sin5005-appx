Given('que possuo alguns produtos cadastrados:') do |table|
  table.hashes.each do |product|
    Product.create!(product)
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
