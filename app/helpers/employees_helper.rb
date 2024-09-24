module EmployeesHelper
  def format_salary(salary)
    number_to_currency(salary, unit: "R$", separator: ",", delimiter: ".")
  end

  def format_date(date)
    date.strftime("%d/%m/%Y") if date.present?
  end

  def employment_status(employee)
    employee.dismissal_date.present? ? "Dismissed" : "Active"
  end
end
