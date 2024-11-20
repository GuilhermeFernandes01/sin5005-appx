# Cenário: Acessar tela de novo fornecedor através da tela principal de fornecedores
Dado('que estou na página principal de fornecedores') do
  visit "/suppliers"
end

Então('para acessa a página de fornecedores devo pressionar o botão {string}') do |link_text|
  click_link(link_text)
end

Então('devo acessar a página para inclusão de um fornecedor')  do
   visit "/suppliers/new"
end
