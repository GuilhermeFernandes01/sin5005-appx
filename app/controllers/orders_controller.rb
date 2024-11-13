class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def create
    product_ids = params[:product_ids]

    @order = Order.new(order_params)

    product_ids.each do |id|
      @order.products << Product.find_by!(id: id)
    end

    if @order.save
      session[:cart] = nil
      redirect_to orders_path, notice: "Pedido foi criado com sucesso!"
    else
      redirect_to cart_index_path, alert: "Erro ao criar o pedido!"
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    redirect_to orders_url, notice: "Pedido foi deletado com sucesso!"
  end

  def order_params
    params.require(:order).permit(:customer_name)
  end
end
