# Cenário: Acessar tela de novo produto através da tela principal de produtos
Dado('que estou na página principal de produtos') do
  visit "/products"
end

Então('pressionar o botão {string}') do |link_text|
  click_link(link_text)
end

Então('devo acessar a página para inclusão de um produto') do
   visit "/products/new"
end
