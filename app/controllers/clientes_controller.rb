class ClientesController < ApplicationController
    def index
      @clientes = Cliente.all
      @quantidade_clientes = Cliente.count
      @clientes_mes_atual = Cliente.where("strftime('%m', data_nascimento) = ?", Date.today.strftime("%m")).count
    end

    def show
      @cliente = Cliente.find(params[:id])
    end

    def new
      @cliente = Cliente.new
    end

    def create
      @cliente = Cliente.new(cliente_params)
      if @cliente.save
        redirect_to clientes_path
      else
        render :new
      end
    end

    def edit
      @cliente = Cliente.find(params[:id])
    end

    def update
      @cliente = Cliente.find(params[:id])

      if @cliente.update(cliente_params)
        redirect_to clientes_path
      else
        render :edit
      end
    end

    def destroy
      @cliente = Cliente.find(params[:id])
      if @cliente.destroy
        redirect_to clientes_path
      else
        redirect_to clientes_path
      end
    rescue ActiveRecord::RecordNotFound => e
      redirect_to clientes_path
    end

    private

    def cliente_params
      params.require(:cliente).permit(:nome, :telefone, :email, :endereco, :data_nascimento, :observacoes)
    end
end
