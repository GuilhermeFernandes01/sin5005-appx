class ClientesController < ApplicationController
    def index
      @clientes = Cliente.all
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
        redirect_to @cliente, notice: "Cliente criado com sucesso."
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
        redirect_to @cliente, notice: "Cliente atualizado com sucesso."
      else
        render :edit
      end
    end

    def destroy
      @cliente = Cliente.find(params[:id])
      @cliente.destroy
      redirect_to clientes_path, notice: "Cliente excluído com sucesso."
    rescue => e
      puts "Erro ao excluir cliente: #{e.message}"
      redirect_to clientes_path, alert: "Erro ao excluir cliente."
    end

    private

    def cliente_params
      params.require(:cliente).permit(:nome, :telefone, :email, :endereco, :observacoes)
    end
end
