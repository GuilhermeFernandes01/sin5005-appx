class SuppliersController < ApplicationController
  before_action :set_supplier, only: [ :show, :update, :edit, :destroy ]

  def new
    @supplier = Supplier.new
  end

  def index
    @suppliers = Supplier.all
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

  def destroy
    @supplier = Supplier.find(params[:id])
    if @supplier.destroy
      flash[:notice] = "Supplier was successfully deleted."
      redirect_to suppliers_path
    else
      flash[:alert] = "Supplier could not be deleted."
      redirect_back(fallback_location: suppliers_path)
    end
  end

  def show
    @supplier = Supplier.find(params[:id])
  end

  def edit
    @supplier = Supplier.find(params[:id])
  end

  def update
    if @supplier.update(supplier_params)
      flash[:notice] = "Supplier was successfully updated."
      redirect_to supplier_path(@supplier)
    else
      flash.now[:alert] = "Supplier could not be updated, please consider the informations sent"
      render :edit
    end
  end

  private

  def set_supplier
    @supplier = Supplier.find(params[:id])
  end

  def supplier_params
    params.require(:supplier).permit(:name, :cnpj, :phone, :email, :segment, :products)
  end
end