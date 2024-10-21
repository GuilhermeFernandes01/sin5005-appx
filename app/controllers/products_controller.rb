class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
    @ingredients = Ingredient.all
  end

  def create
    @product = Product.new(product_params)

    if not @product.save
      @ingredients = Ingredient.all
      render :new, status: :unprocessable_entity
      return
    end

    update_product_ingredients

    redirect_to @product
  end

  def edit
    @product = Product.find(params[:id])
    @ingredients = Ingredient.all
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      update_product_ingredients
      redirect_to @product
    else
      @ingredients = Ingredient.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :category)
  end

  def update_product_ingredients
    if params[:ingredient_ids]
      @product.ingredients = Ingredient.find(params[:ingredient_ids])
    else
      @product.ingredients.clear
    end
  end
end
