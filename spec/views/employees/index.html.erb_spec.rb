require 'rails_helper'

RSpec.describe "employees/index.html.erb", type: :view do
  before do
    @employees = [
      Employee.create!(
        name: "John Doe",
        salary: "50000",
        position: "Developer",
        password: "123456",
        password_confirmation: "123456",
        admission_date: Date.new(2020, 1, 1),
        birth_date: Date.new(1990, 1, 1)
      ),
      Employee.create!(
        name: "Jane Smith",
        salary: "60000",
        position: "Manager",
        password: "123456",
        password_confirmation: "123456",
        admission_date: Date.new(2019, 1, 1),
        birth_date: Date.new(1985, 1, 1)
      )
    ]
    assign(:employees, @employees)
  end

  it "displays all the employees in a table" do
    render

    expect(rendered).to have_selector('h1', text: 'Funcionários')
    expect(rendered).to have_selector('table.general-table')

    @employees.each do |employee|
      expect(rendered).to have_selector('td', text: employee.name)
      expect(rendered).to have_selector('td', text: format_salary(employee.salary))
      expect(rendered).to have_selector('td', text: employee.position)
      expect(rendered).to have_selector('td', text: format_date(employee.admission_date))
      expect(rendered).to have_selector('td', text: format_date(employee.birth_date))

      if employee.dismissal_date.present?
        expect(rendered).to have_selector('td', text: format_date(employee.dismissal_date))
      end

      expect(rendered).to have_link('Exibir', href: employee_path(employee))
      expect(rendered).to have_link('Editar', href: edit_employee_path(employee))
      expect(rendered).to have_button('Demitir')
    end
  end
end
