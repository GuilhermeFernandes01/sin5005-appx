class SupplierController < ApplicationController
  def new
    @supplier = Supplier.new
  end

  def index
    @supplier = Supplier.all
  end

  def create
    @supplier = Supplier.new(supplier_params)
    if @supplier.save
      flash[:notice] = "Supplier was successfully created."
      redirect_to new_supplier_path
    else
      flash.now[:alert] = "Supplier not created"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def supplier_params
    params.require(:supplier).permit(:name, :cnpj, :phone, :email, :segment, :products)
  end
end
