require 'rails_helper'

RSpec.describe IngredientsController, type: :controller do
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
end
