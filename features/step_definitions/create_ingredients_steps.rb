# require 'rails_helper'

# Cenário: Cadastrar um novo ingrediente
Quando ('eu acesso a página de cadastro de ingredientes') do
  visit ingredients_path
end

Então ('eu devo ver um formulário para cadastrar um novo ingrediente') do
    expect(page).to have_field('#name')
  #  expect(page).to have_field('ingredient_unityMeasure')
  #  expect(page).to have_field('ingredient_quantiyStock')
  #  expect(page).to have_button('Create Ingredient')
end

# Quando 'eu preencho o formulário com:' do |table|
#  table.hashes.each do |row|
#    fill_in 'Nome', with: row['Nome']
#    fill_in 'Unidade de Medida', with: row['Unidade de Medida']
#    fill_in 'Quantidade em Estoque', with: row['Quantidade em Estoque']
#  end
# end

# Quando 'eu clico no botão "Criar"' do
#  click_button 'Criar'
# end

# Então 'eu devo ser redirecionado para a página de listagem de ingredientes' do
#  expect(current_path).to eq(ingredients_path)
# end

# Então 'eu devo ver a mensagem de sucesso "Ingrediente cadastrado com sucesso!"' do
#  expect(page).to have_content('Ingrediente cadastrado com sucesso!')
# end


#Então 'eu devo ver o ingrediente "Queijo" na lista com a unidade "g" e a quantidade "1000"' do
#  expect(page).to have_content('Queijo')
#  expect(page).to have_content('g')
#  expect(page).to have_content('1000')
# end
