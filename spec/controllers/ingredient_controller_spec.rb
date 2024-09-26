require 'rails_helper'

RSpec.describe IngredientsController, type: :controller do
  # Define um exemplo de ingrediente para usar nos testes
  let(:valid_ingredient_attributes) { { name: 'Tomate', unityMeasure: 'kg', quantityStock: 1000 } }

  # Cria um ingrediente válido para testes
  let(:valid_ingredient) { create(:ingredient, valid_ingredient_attributes) }

  # Define exemplos de atributos inválidos para testes
  let(:invalid_ingredient_attributes) { { name: '', unityMeasure: nil, quantityStock: nil } }

  describe 'GET #index' do
    it 'assigns all ingredients to @ingredients' do
      get :index
      expect(assigns(:ingredients)).to eq(Ingredient.all)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
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
end
