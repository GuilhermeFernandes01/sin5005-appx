# Cenário: Filtrar ingredientes
Dado ('que estou na página de ingredientes') do
  visit ingredients_path
end

Então ('existindo os seguintes ingredientes:') do |table|
  table.hashes.each do |row|
    Ingredient.create(name: row['Name'], unityMeasure: row['Unity Measure'], quantityStock: row['Quantity Stock'], quantityStockMin: row['Quantity Stock Min'], quantityStockMax: row['Quantity Stock Max'])
  end
end

Quando('eu preencher a caixa de texto {string} com {string}') do |field, value|
  fill_in field, with: value
end

Então('pressionar o botão {string} para procurar ou filtrar') do |button|
  click_button button
end

Então('devo ver somente o ingrediente {string}') do |ingredient_name|
  # Verificar se o ingrediente esperado está na página
  expect(page).to have_content(ingredient_name)

  # Verificar se os outros ingredientes não estão na página
  Ingredient.where.not(name: ingredient_name).each do |ingredient|
    expect(page).not_to have_content(ingredient.name)
  end
end
