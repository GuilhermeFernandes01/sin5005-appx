# Create
Given("I am on the create supplier registration page") do
  visit new_supplier_path
 end

 When("I fill {string} with {string}") do |field, value|
  fill_in "supplier[#{field}]", with: value
 end

 When("I submit the supplier form") do
  click_button "Criar Fornecedor"
 end

 Then("I must see a success message") do
  expect(page).to have_content("Supplier was successfully created.")
 end
 When("I fill in the new supplier form with invalid data or blank") do
  fill_in "supplier[name]", with: ""
  fill_in "supplier[cnpj]", with: "invalid_cnpj"
  fill_in "supplier[phone]", with: "123"
  fill_in "supplier[email]", with: "invalid_email"
  fill_in "supplier[segment]", with: ""
  fill_in "supplier[products]", with: ""
 end

 Then("I must see error messages") do
  expect(page).to have_selector('.alert-danger')
 end

 Then("I must see an alert message") do
  expect(page).to have_selector('h1', text: "Cadastro de Fornecedores")
 end

 # List
 Given('there are registered suppliers') do
  Supplier.delete_all
  puts "Suppliers count after deletion: #{Supplier.count}" # Debug
  @supplier1 = Supplier.create!(code: "SUP_#{SecureRandom.hex(4)}", name: 'Supplier 1', cnpj: '11111111111111', phone: '(11) 1234-5678', email: 'supplier1@test.com', segment: 'cheese', products: 'products')
  @supplier2 = Supplier.create!(code: "SUP_#{SecureRandom.hex(4)}", name: 'Supplier 2', cnpj: '22222222222222', phone: '(11) 8765-4321', email: 'supplier2@test.com', segment: 'sauce', products: 'other products')
  puts "Suppliers count after creation: #{Supplier.count}" # Debug
 end

 When('I visit the suppliers listing page') do
  visit suppliers_path
 end

 Then('I should see a table with supplier information') do
  expect(page).to have_css('table')
 end

 Then('the table should contain {string}, {string}, {string}, {string}, {string}, {string} and {string}') do |code, name, cnpj, phone, email, segment, products|
  within 'table' do
    expect(page).to have_content(code)
    expect(page).to have_content(name)
    expect(page).to have_content(cnpj)
    expect(page).to have_content(phone)
    expect(page).to have_content(email)
    expect(page).to have_content(segment)
    expect(page).to have_content(products)
  end
end


 Then('I should see supplier {string}') do |supplier|
  expect(page).to have_content(supplier)
 end

 # Delete
 When("I press the button {string} from {string}") do |button_text, supplier_name|
  within('table') do
    supplier_row = find('tr', text: supplier_name)
    supplier_row.click_button("Excluir")
  end
end

 Then('I should no longer see {string} in the suppliers list') do |supplier_name|
  expect(page).not_to have_content(supplier_name)
 end

 Then('I should see a message saying {string}') do |message|
  expect(page).to have_content(message)
 end
