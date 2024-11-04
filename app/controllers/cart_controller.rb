class CartController < ApplicationController
  before_action :set_cart

  def index
  end

  def add_product
    product = Product.find_by(id: params[:product_id])

    if not product
      redirect_to cart_index_path, alert: "Produto não encontrado"
      return
    end

    @cart.items << product

    session[:cart] = @cart.items.map(&:id)

    redirect_to cart_index_path, notice: "#{product.name} foi adicionado ao carrinho."
  end

  def remove_product
    product = Product.find_by(id: params[:product_id])

    if not product
      redirect_to cart_index_path, alert: "Produto não encontrado"
      return
    end

    index = @cart.items.index(product)
    @cart.items.delete_at(index) if index

    session[:cart] = @cart.items.map(&:id)

    redirect_to cart_index_path, notice: "#{product.name} foi removido do carrinho."
  end

  private

  def set_cart
    @cart = Cart.new

    if session[:cart]
      session[:cart].each do |product_id|
        @cart.items << Product.find(product_id)
      end
    end
  end
end
