Dado('que estou na página inicial do sistema') do
  visit root_path
end

Quando('vejo o menu drop-down de navegação') do
 find("#menu-home")
end

Então('devo ver as opções {string}, {string}, {string}, {string}, {string} e {string}') do | string, string2, string3, string4, string5, string6|
  menu_home = find("#menu-home")
  # Verificando se o menu contém os links esperados
  expect(menu_home).to have_content(string)
  expect(menu_home).to have_content(string2)
  expect(menu_home).to have_content(string3)
  expect(menu_home).to have_content(string4)
  expect(menu_home).to have_content(string5)
  expect(menu_home).to have_content(string6)
end
