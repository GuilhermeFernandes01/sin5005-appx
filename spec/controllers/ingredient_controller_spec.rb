require 'rails_helper'

RSpec.describe IngredientsController, type: :controller do
  include FactoryBot::Syntax::Methods
  # Define um exemplo de ingrediente para usar nos testes
  let(:valid_ingredient_attributes) { { name: 'Tomate', unityMeasure: 'kg', quantityStock: 1000, quantityStockMin: 10, quantityStockMax: 2000 } }

  # Cria um ingrediente válido para testes
  let(:valid_ingredient) { create(:ingredient, valid_ingredient_attributes) }

  # Define exemplos de atributos inválidos para testes
  let(:invalid_ingredient_attributes) { { name: '', unityMeasure: nil, quantityStock: nil, quantityStockMin: nil, quantityStockMax: nil } }

  let(:updated_ingredient_attributes) { { name: 'Cebola', unityMeasure: 'g', quantityStock: 500, quantityStockMin: 20, quantityStockMax: 3000 } }
  let(:ingredient) { create(:ingredient, valid_ingredient_attributes) }

  describe 'GET #index' do
    let!(:ingredient) { create(:ingredient) } # Usando FactoryBot para criar um ingrediente válido
    let!(:ingredient_menor) { create(:ingredient, quantityStock: 5, quantityStockMin: 10) }
    let!(:ingredient_maior) { create(:ingredient, quantityStock: 15, quantityStockMin: 10) }

    it 'assigns all ingredients to @ingredients' do
      get :index
      expect(assigns(:ingredients)).to eq(Ingredient.all)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    context "using filter 'menor_estoque_min'" do
      it 'returns ingredients with quantityStock less or equal than quantityStockMin' do
        get :index, params: { filter: 'menor_estoque_min' }
        expect(assigns(:ingredients)).to include(ingredient_menor)
        expect(assigns(:ingredients)).not_to include(ingredient_maior)
      end
    end

    context "using filter 'maior_estoque_min'" do
      it 'returns ingredients with quantityStock greater than quantityStockMin' do
        get :index, params: { filter: 'maior_estoque_min' }
        expect(assigns(:ingredients)).to include(ingredient_maior)
        expect(assigns(:ingredients)).not_to include(ingredient_menor)
      end
    end
  end

  describe 'GET #index filter by name' do
    let!(:ingredient_1) { create(:ingredient, name: 'Leite') }
    let!(:ingredient_2) { create(:ingredient, name: 'Queijo') }

    it 'assigns all ingredients to @ingredients' do
      get :index
      expect(assigns(:ingredients)).to eq(Ingredient.all)
    end

    context 'with name filter' do
      it 'filters ingredients by name' do
        get :index, params: { name: 'Leite' }
        expect(assigns(:ingredients)).to include(ingredient_1)
        expect(assigns(:ingredients)).not_to include(ingredient_2)
      end

      it 'filters ingredients by partial name match' do
        get :index, params: { name: 'Lei' }  # Buscando "Lei" como parte de "Leite"
        expect(assigns(:ingredients)).to include(ingredient_1)
        expect(assigns(:ingredients)).not_to include(ingredient_2)  # "Queijo" não deve ser incluído
      end
  
      it 'returns all ingredients if the name filter is not present' do
        get :index
        expect(assigns(:ingredients)).to include(ingredient_1, ingredient_2)
      end
    end
  end

  describe 'GET #new' do
    it 'assigns a new ingredient to @ingredient' do
      get :new
      expect(assigns(:ingredient)).to be_a_new(Ingredient)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new ingredient' do
        expect {
          post :create, params: { ingredient: valid_ingredient_attributes }
        }.to change(Ingredient, :count).by(1)
      end

      it 'redirects to the created ingredient' do
        post :create, params: { ingredient: valid_ingredient_attributes }
        expect(response).to redirect_to(Ingredient.last)
      end

      it 'sets a flash notice' do
        post :create, params: { ingredient: valid_ingredient_attributes }
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new ingredient' do
        expect {
          post :create, params: { ingredient: invalid_ingredient_attributes }
        }.not_to change(Ingredient, :count)
      end

      it 'renders the new template' do
        post :create, params: { ingredient: invalid_ingredient_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      it 'updates the requested ingredient' do
        put :update, params: { id: ingredient.id, ingredient: updated_ingredient_attributes }
        ingredient.reload  # Recarrega o objeto da base de dados para verificar a atualização
        expect(ingredient.name).to eq('Cebola')
        expect(ingredient.unityMeasure).to eq('g')
        expect(ingredient.quantityStock).to eq(500)
        expect(ingredient.quantityStockMin).to eq(20)
        expect(ingredient.quantityStockMax).to eq(3000)
      end

      it 'redirects to the ingredient' do
        put :update, params: { id: ingredient.id, ingredient: updated_ingredient_attributes }
        expect(response).to redirect_to(ingredient)
      end

      it 'sets a flash notice' do
        put :update, params: { id: ingredient.id, ingredient: updated_ingredient_attributes }
        expect(flash[:notice]).to eq('Ingredient was successfully updated.')
      end
    end

    context 'with invalid attributes' do
      it 'does not update the ingredient' do
        original_name = ingredient.name
        put :update, params: { id: ingredient.id, ingredient: invalid_ingredient_attributes }
        ingredient.reload
        expect(ingredient.name).to eq(original_name)  # O nome não deve ser alterado
      end

      it 'renders the edit template' do
        put :update, params: { id: ingredient.id, ingredient: invalid_ingredient_attributes }
        expect(response).to render_template(:edit)
      end

      it 'sets a flash alert or error' do
        put :update, params: { id: ingredient.id, ingredient: invalid_ingredient_attributes }
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:ingredient) { create(:ingredient) }  # Cria um ingrediente para ser destruído

    it 'deletes the ingredient' do
      expect {
        delete :destroy, params: { id: ingredient.id }
      }.to change(Ingredient, :count).by(-1)  # Verifica se o número de ingredientes diminui
    end

    it 'redirects to the ingredients index' do
      delete :destroy, params: { id: ingredient.id }
      expect(response).to redirect_to(ingredients_path)  # Verifica se redireciona corretamente
    end

    it 'sets a flash notice' do
      delete :destroy, params: { id: ingredient.id }
      expect(flash[:notice]).to be_present  # Verifica se uma mensagem de sucesso é definida
    end

    it 'responds with no content for JSON requests' do
      delete :destroy, params: { id: ingredient.id }, format: :json
      expect(response).to have_http_status(:no_content)  # Verifica se o status da resposta é 204 No Content
    end
  end

  describe 'validations quantitys' do
    it 'is invalid if quantityStockMin is greater than quantityStockMax' do
      ingredient = Ingredient.new(
        name: 'Tomate',
        unityMeasure: 'kg',
        quantityStock: 1000,
        quantityStockMin: 200,  # Valor maior
        quantityStockMax: 100   # Valor menor
      )
      expect(ingredient).not_to be_valid
      expect(ingredient.errors[:quantityStockMin]).to include("não pode ser maior que o estoque máximo")
    end

    it 'is valid if quantityStockMin is less than or equal to quantityStockMax' do
      ingredient = Ingredient.new(
        name: 'Cenoura',
        unityMeasure: 'kg',
        quantityStock: 500,
        quantityStockMin: 100,
        quantityStockMax: 200
      )
      expect(ingredient).to be_valid  # Deve ser válido
    end
  end
end
