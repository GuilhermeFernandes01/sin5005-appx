class EmployeesController < ApplicationController
  def index
    @employees = Employee.all
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      flash[:notice] = "Employee was successfully created."
      redirect_to employees_path
    else
      flash[:alert] = "Employee not created"
      render :new, status: :unprocessable_entity
    end
  end

  def employee_params
    params.require(:employee).permit(:name, :salary, :position, :password, :password_confirmation, :admission_date, :birth_date)
  end
end
