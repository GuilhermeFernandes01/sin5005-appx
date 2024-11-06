When('I click the button to show details of the employee {string}') do |employee_name|
  click_link 'Exibir', match: :first
end

Then('I should see the employee details containing {string}') do |text|
  expect(page).to have_content(text)
end
