class EmployeesController < ApplicationController
  def index
    @employees = Employee.all
  end

  def show
    @employee = Employee.find_by(id: params[:id])
  end

  def new
    @employee = Employee.new
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])

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
    @employee = Employee.find_by(id: params[:id])

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
end
