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
  expect(page).to have_selector('h1', text: "Supplier Registration")
end
