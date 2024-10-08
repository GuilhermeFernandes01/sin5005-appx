class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if not @product.save
      render :new, status: :unprocessable_entity
      return
    end

    redirect_to "/products/new"
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to products_path
  end

  def product_params
    params.require(:product).permit(:name, :price, :category, :require_ingredients)
  end
end
