include EmployeesHelper
include ActionView::Helpers::NumberHelper
Given("the following employees exist:") do |table|
  table.hashes.each do |employee|
    employee_data = employee.except("dismissal_date")
    created_employee = Employee.create!(employee_data)
    created_employee.fire(employee[:dismissal_date]) if employee[:dismissal_date].present?
  end
end

When("I visit the employees page") do
  visit employees_path
end

Then("I should see the list of employees containing {string}") do |text|
  expect(page).to have_content(text)
end

Then("I should see the list of employees containing formatted salary {string}") do |salary|
  numeric_salary = salary.split(":").last.strip.to_i
  formatted_salary = "Salário: #{format_salary(numeric_salary)}"
  expect(page).to have_content(formatted_salary)
end

Then("I should see the list of employees containing formatted date {string}") do |date|
  date_text = date.split(":").first.strip
  date_value = date.split(":").last.strip
  formatted_date = "#{date_text}: #{format_date(Date.parse(date_value))}"
  expect(page).to have_content(formatted_date)
end

Then("I should see the list of employees containing formatted date {string} if {string} is present") do |date, condition|
  if condition.present?
    date_text = date.split(":").first.strip
    date_value = date.split(":").last.strip
    formatted_date = "#{date_text}: #{format_date(Date.parse(date_value))}"

    expect(page).to have_content(formatted_date)
  end
end
