include EmployeesHelper
include ActionView::Helpers::NumberHelper

Given("I am on the new employee page") do
  visit new_employee_path
end

When("I fill in the new employee form with valid data") do
  fill_in "Nome completo", with: "John Doe"
  fill_in "Salário (R$)", with: "50000"
  fill_in "Cargo", with: "Developer"
  fill_in "Data de admissão", with: "2020-01-01"
  fill_in "Data de nascimento", with: "1990-01-01"
  fill_in "Senha", with: "123456"
  fill_in "Confirmação da senha", with: "123456"
end

When("I fill in the new employee form with invalid data") do
  fill_in "Nome completo", with: ""
  fill_in "Salário (R$)", with: ""
  fill_in "Cargo", with: ""
  fill_in "Data de admissão", with: ""
  fill_in "Data de nascimento", with: ""
  fill_in "Senha", with: ""
  fill_in "Confirmação da senha", with: ""
end

When("I submit the form") do
  click_button "Criar funcionário"
end

Then("I should see a success message") do
  expect(page).to have_content("Funcionário foi criado com sucesso.")
end

Then("I should see the new employee in the employee list") do
  visit employees_path
  expect(page).to have_content("John Doe")
end

Then("I should see error messages") do
  expect(page).to have_content("can't be blank")
end

Then("I should see an alert message {string}") do |message|
  expect(page).to have_content(message)
end
