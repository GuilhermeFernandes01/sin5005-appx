class IngredientsController < ApplicationController
  before_action :set_ingredient, only: %i[ show edit update destroy ]

  # GET /ingredients or /ingredients.json
  def index
    @ingredients = Ingredient.all

    # Filtros quantidade
    if params[:filter] == "menor_estoque_min"
      @ingredients = Ingredient.where("\"quantityStock\" <= \"quantityStockMin\"")
    elsif params[:filter] == "maior_estoque_min"
      @ingredients = Ingredient.where("\"quantityStock\" > \"quantityStockMin\"")
    end

    # Filtro pelo nome
    if params[:name].present?
      @ingredients = @ingredients.where("name LIKE ?", "%#{params[:name]}%")
    end
  end

  # GET /ingredients/1 or /ingredients/1.json
  def show
  end

  # GET /ingredients/new
  def new
    @ingredient = Ingredient.new
  end

  # GET /ingredients/1/edit
  def edit
  end

  # POST /ingredients or /ingredients.json
  def create
    @ingredient = Ingredient.new(ingredient_params)

    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to @ingredient, notice: "Ingrediente foi criado com sucesso." }
        format.json { render :show, status: :created, location: @ingredient }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ingredients/1 or /ingredients/1.json
  def update
    respond_to do |format|
      if @ingredient.update(ingredient_params)
        format.html { redirect_to @ingredient, notice: "Ingrediente foi atualizado com sucesso." }
        format.json { render :show, status: :ok, location: @ingredient }
      else
        format.html do
          flash[:alert] = "Falha ao atualizar ingrediente."  # Adicione o flash de erro
          render :edit, status: :unprocessable_entity
        end
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredients/1 or /ingredients/1.json
  def destroy
    @ingredient.destroy!

    respond_to do |format|
      format.html { redirect_to ingredients_path, status: :see_other, notice: "Ingrediente foi excluído com sucesso." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredient
      @ingredient = Ingredient.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ingredient_params
      params.require(:ingredient).permit(:name, :unityMeasure, :quantityStock, :quantityStockMin, :quantityStockMax)
    end
end
