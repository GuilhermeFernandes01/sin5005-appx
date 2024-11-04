require 'rails_helper'

RSpec.describe ClientesController, type: :controller do
  let!(:cliente1) { create(:cliente, nome: "João Silva", telefone: "123456789", email: "joao@example.com", endereco: "Rua A, 123", data_nascimento: "1984-11-05") }
  let!(:cliente2) { create(:cliente, nome: "Maria Oliveira", telefone: "987654321", email: "maria@example.com", endereco: "Rua B, 456", data_nascimento: "1985-11-15") }
  let!(:cliente3) { create(:cliente, nome: "Carlos Santos", telefone: "555555555", email: "carlos@example.com", endereco: "Rua C, 789", data_nascimento: "1990-12-01") }

  let(:valid_cliente_attributes) { { nome: "Abc 123", telefone: "9999", email: "teste@gmai.com", endereco: "Abcd 12", observacoes: "Abc", data_nascimento: "1990-01-01" } }
  let(:invalid_cliente_attributes) { { nome: "", telefone: 9999, email: "testegmail.com", endereco: "Abcd 12", observacoes: "Abc" } }

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    context 'with search params' do
      it 'returns clients that match the search' do
        get :index, params: { search: "João" }
        expect(assigns(:clientes)).to include(cliente1)
        expect(assigns(:clientes)).not_to include(cliente2, cliente3)
      end

      it 'returns no clients when no match is found' do
        get :index, params: { search: "NãoExistente" }
        expect(assigns(:clientes)).to be_empty
      end
    end

    context 'without search params' do
      it 'returns all clients' do
        get :index
        expect(assigns(:clientes)).to include(cliente1, cliente2, cliente3)
      end

      it 'counts total clients and birthday clients in the current month' do
        get :index
        expect(assigns(:quantidade_clientes)).to eq(3)
        expect(assigns(:clientes_mes_atual)).to eq(2)
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
    context 'with valid attributes' do
      it 'creates a new cliente and redirects to index' do
        expect {
          post :create, params: { cliente: valid_cliente_attributes }
        }.to change(Cliente, :count).by(1)
        expect(response).to redirect_to(clientes_path)
      end
    end

    context 'with invalid attributes' do
      it 'renders the new template' do
        post :create, params: { cliente: invalid_cliente_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      get :show, params: { id: cliente1.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #edit' do
    it 'renders the edit template' do
      get :edit, params: { id: cliente1.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the cliente and redirects to index' do
        patch :update, params: { id: cliente1.id, cliente: { nome: "Nome Atualizado" } }
        expect(cliente1.reload.nome).to eq("Nome Atualizado")
        expect(response).to redirect_to(clientes_path)
      end
    end

    context 'with invalid attributes' do
      it 'renders the edit template' do
        patch :update, params: { id: cliente1.id, cliente: invalid_cliente_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the cliente and redirects to index' do
      expect {
        delete :destroy, params: { id: cliente1.id }
      }.to change(Cliente, :count).by(-1)
      expect(response).to redirect_to(clientes_path)
    end
  end

  after(:all) do
    Cliente.delete_all
  end
end
