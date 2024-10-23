class SuppliersController < ApplicationController
  before_action :set_supplier, only: [ :show, :update, :edit, :destroy ]

  def new
    @supplier = Supplier.new
  end

  def index
    @suppliers = Supplier.all

    if params[:search_by_code].present?
      @suppliers = @suppliers.where("code LIKE ?", "%#{params[:search_by_code]}%")
    end
    if params[:search_by_name].present?
      @suppliers = @suppliers.where("name LIKE ?", "%#{params[:search_by_name]}%")
    end
    if params[:search_by_segment].present?
      @suppliers = @suppliers.where("segment LIKE ?", "%#{params[:search_by_segment]}%")
    end
    if params[:search_by_products].present?
      @suppliers = @suppliers.where("products LIKE ?", "%#{params[:search_by_products]}%")
    end
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
    end

    redirect_to suppliers_path
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

  def search_params
    params.permit(:search_by_code, :search_by_name, :search_by_segment, :search_by_products)
  end
end
