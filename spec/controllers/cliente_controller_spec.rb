
require 'rails_helper'

RSpec.describe ClientesController, type: :controller do
  # Define um exemplo de cliente para usar nos testes
  let(:valid_cliente_attributes) { { nome: "Abc 123", telefone: 9999, email: "teste@gmai.com", endereco: "Abcd 12", observacoes: "Abc" } }
  
  # Cria clientes válidos para testes
  let!(:cliente1) { create(:cliente, nome: "João Silva", telefone: "123456789", email: "joao@example.com", endereco: "Rua A, 123", data_nascimento: "1990-01-01") }

  let!(:cliente2) { create(:cliente, nome: "Maria Oliveira", telefone: "987654321", email: "maria@example.com", endereco: "Rua B, 456", data_nascimento: "1985-05-05") }
  

  # Define exemplos de atributos inválidos para testes
  let(:invalid_cliente_attributes) { { nome: "", telefone: 9999, email: "testegmai.com", endereco: "Abcd 12", observacoes: "Abc" } }

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    context 'with search params' do
      it 'returns clients that match the search' do
        get :index, params: { search: "João" }
        expect(assigns(:clientes)).to include(cliente1)
        expect(assigns(:clientes)).not_to include(cliente2)
      end

      it 'returns no clients when no match is found' do
        get :index, params: { search: "NãoExistente" }
        expect(assigns(:clientes)).to be_empty
      end
    end

    context 'without search params' do
      it 'returns all clients' do
        get :index
        expect(assigns(:clientes)).to include(cliente1, cliente2)
      end
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with invalid attributes' do
      it 'renders the new template' do
        post :create, params: { cliente: invalid_cliente_attributes }
        expect(response).to render_template(:new)
      end
    end
  end
end
