# Cenário: Visualizar todos as categorias de produtos cadastrados no cardápio

Dado('que temos alguns produtos cadastrados:') do |table|
    table.hashes.each do |row|
        Product.create(name: row['name'], price: row['price'], category: row['category'])
    end
end

Quando('que eu acesso a página de cardápio') do
  visit '/cardapio'
end

Então('devo ver essas categorias {string} e {string} como opções') do |string1, string2|
    expect(page).to have_content(string1)
    expect(page).to have_content(string2)
end

Dado('que cliquei no botão {string}') do |string|
    click_link(string)
end

Então('devo Visualizar somente produtos da categoria {string}') do |string|
    visit '/products?category=' + string
    within('table')
    expect(page).to have_content(string)
     within "tbody" do
      expect(page).to have_selector('tr', count: 1)
    end
end





