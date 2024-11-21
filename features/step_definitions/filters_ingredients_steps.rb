  # Cenário 'Visualizar todos os ingredientes'

  Quando ('que eu acesso a página de ingredientes') do
    visit ingredients_path
  end

  Então('devem existir os seguintes ingredientes cadastrados:') do |table|
    table.hashes.each do |row|
      Ingredient.create(name: row['Nome'], unityMeasure: row['Unidade de medição'], quantityStock: row['Quantidade em estoque'], quantityStockMin: row['Quantidade mínima em estoque'], quantityStockMax: row['Quantidade máxima em estoque'])
    end
  end

  Quando('eu pressionar o botão {string}') do |link_text|
    click_link(link_text)
  end

  Então('eu devo continuar vendo todos os ingredientes listados') do
    within('table#ingredients-list')
    expect(page).to have_content('Queijo')
    expect(page).to have_content('Leite')
    expect(page).to have_content('Tomate')
    within "#ingredients tbody" do
      expect(page).to have_selector('tr', count: 3)
    end
  end

  # Cenário: Filtrar ingredientes com estoque menor ou igual ao estoque mínimo
  Dado ('que continuo na página de ingredientes') do
    visit ingredients_path
  end

  Então('com os seguintes ingredientes cadastrados:') do |table|
    table.hashes.each do |row|
      Ingredient.create(name: row['Nome'], unityMeasure: row['Unidade de medição'], quantityStock: row['Quantidade em estoque'], quantityStockMin: row['Quantidade mínima em estoque'], quantityStockMax: row['Quantidade máxima em estoque'])
    end
  end

  Quando('eu clicar no botão {string} para filtrar') do |text|
    click_link(text)
  end

  Então('devo ver os ingredientes {string} e {string}') do |string, string2|
    within('table#ingredients-list')
    expect(page).to have_content(string)
    expect(page).to have_content(string2)
    within "#ingredients tbody" do
      expect(page).to have_selector('tr', count: 2)
    end
  end

  # Cenário: Filtrar ingredientes com estoque maior que o estoque mínimo
  Dado('que eu acesso a página de cadastro de ingredientes') do
    visit ingredients_path
  end

  Então('vejo os ingredientes listados:') do |table|
    table.hashes.each do |row|
      Ingredient.create(name: row['Nome'], unityMeasure: row['Unidade de medição'], quantityStock: row['Quantidade em estoque'], quantityStockMin: row['Quantidade mínima em estoque'], quantityStockMax: row['Quantidade máxima em estoque'])
    end
  end

  Quando('eu filtrar pela opção {string}') do |text|
    click_link(text)
  end

  Então('devo ver o ingrediente {string}') do |string|
    within('table#ingredients-list')
    expect(page).to have_content(string)
     within "#ingredients tbody" do
      expect(page).to have_selector('tr', count: 1)
    end
  end
