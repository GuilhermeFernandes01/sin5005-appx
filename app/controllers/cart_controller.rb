class CartController < ApplicationController
  before_action :set_cart

  def index
    @freight_value = flash[:freight_value]
    @error_message = flash[:alert]
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

  def calculate_freight
    client_address = params[:endereco]
    freight_calculator = FreightCalculatorService.new(client_address)

    begin
      # Calculando o valor do frete
      freight_value = freight_calculator.calculate_freight
      flash[:freight_value] = freight_value  # Armazenando o valor do frete
      flash[:notice] = "Frete calculado com sucesso."  # Mensagem de sucesso
    rescue => e
      flash[:alert] = "Erro ao calcular frete: #{e.message}"  # Mensagem de erro
    end

    redirect_to cart_index_path
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
