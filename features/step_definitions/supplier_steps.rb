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

When("I confirm the deletion") do
  page.accept_confirm("Você tem certeza que deseja excluir este fornecedor?")
end

 Then('I should no longer see {string} in the suppliers list page') do |supplier_name|
  expect(page).not_to have_content(supplier_name)
 end

 Then('I should see a message saying "Supplier was successfully deleted."') do
  expect(page).to have_content("Supplier was successfully deleted.")
end

Then('I should see {string} in the supplier show page') do |supplier_name|
  expect(page).to have_content(supplier_name)
end

 When("I don't confirm the deletion") do
  page.driver.browser.switch_to.alert.dismiss
end


Then('I should see {string} in the suppliers list') do |supplier_name|
  expect(page).to have_content(supplier_name)
end

Then('I should see a message saying "Supplier deletion was cancelled."') do
  expect(page).to have_content("Supplier deletion was cancelled.")
end


# Edit/Update
When("I click 'Ver' for {string}") do |supplier_name|
  within('table') do
    supplier_row = find('tr', text: supplier_name)
    click_link("Ver", match: :first)
  end
end

Then("I should be on the show page for {string}") do |supplier_name|
  supplier = Supplier.find_by(name: supplier_name)
  expect(page).to have_current_path(supplier_path(supplier)) if supplier
end

Then("I click {string}") do |button_text|
  click_link("Editar")
end

When("I am on the edit page from {string}") do |supplier_name|
  supplier = Supplier.find_by(name: supplier_name)
  expect(page).to have_current_path(edit_supplier_path(supplier)) if supplier
end

When("I edit the name to {string}, phone to {string}, email to {string}, segment to {string}, and products to {string}") do |name, phone, email, segment, products|
  fill_in "supplier[name]", with: name
  fill_in "supplier[phone]", with: phone
  fill_in "supplier[email]", with: email
  fill_in "supplier[segment]", with: segment
  fill_in "supplier[products]", with: products
end

When("I click on the {string} button to confirm the new information") do |button_text|
  click_button "Salvar"
end


Then("I should see {string} on the show page") do |supplier_name|
  expect(page).to have_content(supplier_name)
end

Then("I should see the updated details for phone, email, segment, and products") do
  expect(page).to have_content("(11) 98765-4321")
  expect(page).to have_content("modified@example.com")
  expect(page).to have_content("Modified Segment")
  expect(page).to have_content("Modified Products")
end

Then("I should see a link to go back to the suppliers list") do
  expect(page).to have_link("Retornar para a Lista de Fornecedores", href: suppliers_path)
end

# Filter
Given("there are suppliers with various codes, names, segments, and products") do
  Supplier.create!(code: 'SUP001', name: 'Supplier One', cnpj: '11111111111111', phone: '(11) 1234-5678', email: 'supplier1@test.com', segment: 'Segment A', products: 'Product A')
  Supplier.create!(code: 'SUP002', name: 'Supplier Two', cnpj: '11111111111112', phone: '(11) 1234-5678', email: 'supplier1@test.com', segment: 'Segment B', products: 'Product B')
  Supplier.create!(code: 'SUP003', name: 'Supplier Three', cnpj: '11111111111113', phone: '(11) 1234-5678', email: 'supplier1@test.com', segment: 'Segment A', products: 'Product C')
end

When("I search with {string}") do |terms|
  terms.split(', ').each do |term|
    term = term.strip
    case term
    when /^SUP\d+$/
      fill_in 'search_by_code', with: term
    when /Supplier/
      fill_in 'search_by_name', with: term
    when /Segment/
      fill_in 'search_by_segment', with: term
    when /Product/
      fill_in 'search_by_products', with: term
    else
      raise "Termo desconhecido: #{term}"
    end
  end
  click_button "Filtrar"
end

Then("I should see {string} on Listing Page") do |string|
  expect(page).to have_content(string.strip)
end

When("I clean the search bar") do
  click_link "Limpar Filtro"
end

Then("I should see the Listing Page with all Suppliers") do
  expect(page).to have_content("Fornecedores Cadastrados")
end

Given("I am on the suppliers listing page") do
  visit suppliers_path
end

Then("I should see the message {string}") do |message|
  expect(page).to have_content(message)
end
