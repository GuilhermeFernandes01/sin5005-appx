class EmployeesController < ApplicationController
  before_action :set_employee, only: [ :show, :edit, :update, :fire ]

  def index
    if params[:search].present?
      @employees = Employee.where("name LIKE ?", "%#{params[:search]}%")
    else
      @employees = Employee.all
    end
  end

  def show
  end

  def new
    @employee = Employee.new
  end

  def edit
  end

  def update
    if @employee.update(employee_params)
      redirect_to employees_path
    else
      render :edit
    end
  end

  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      flash[:success] = "Funcionário foi criado com sucesso."
      redirect_to employees_path
    else
      flash.now[:danger] = "Não foi possível criar o funcionário."
      render :new, status: :unprocessable_entity
    end
  end

  def fire
    if @employee && @employee.update(dismissal_date: Time.current)
      flash[:success] = "Funcionário demitido com sucesso."
      redirect_to @employee
    else
      flash[:danger] = "Não foi possível demitir o funcionário."
      redirect_to @employee
    end
  end

  def employee_params
    params.require(:employee).permit(:name, :salary, :position, :password, :password_confirmation, :admission_date, :birth_date)
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render partial: "employees/employee_not_found", status: :not_found
  end
end
