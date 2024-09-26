require 'rails_helper'

RSpec.describe ClientesController, type: :controller do
  # Define um exemplo de clientee para usar nos testes
  let(:valid_cliente_attributes) { { nome: "Abc 123", telefone: 9999, email: "teste@gmai.com", endereco: "Abcd 12", observacoes: "Abc" } }
  # Cria um cliente válido para testes
  let(:valid_cliente) { create(:cliente, valid_cliente_attributes) }

  # Define exemplos de atributos inválidos para testes
  let(:invalid_cliente_attributes) { { nome: "", telefone: 9999, email: "testegmai.com", endereco: "Abcd 12", observacoes: "Abc" } }

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'sets a flash notice' do
        post :create, params: { cliente: valid_cliente_attributes }
        expect(flash[:notice]).to be_present
      end
    end

    context 'with invalid attributes' do
      it 'renders the new template' do
        post :create, params: { cliente: invalid_cliente_attributes }
        expect(response).to render_template(:new)
      end
    end
  end
end
