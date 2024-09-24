require 'rails_helper'

RSpec.describe SupplierController, type: :controller do
  describe 'GET #new' do
    it 'assigns a new supplier to @supplier' do
      get :new
      expect(assigns(:supplier)).to be_a_new(Supplier)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new supplier' do
        expect {
          post :create, params: { supplier: {
            name: 'Supplier 1',
            cnpj: '12345678000199', # CNPJ válido
            phone: '(11) 99999-9999', # Telefone no formato correto
            email: 'supplier@example.com',
            segment: 'Segment A',
            products: 'Product A'
          } }
        }.to change(Supplier, :count).by(1)
      end

      it 'redirects to the supplier index path' do
        post :create, params: { supplier: {
          name: 'Supplier 1',
          cnpj: '12345678000199',
          phone: '(11) 99999-9999',
          email: 'supplier@example.com',
          segment: 'Segment A',
          products: 'Product A'
        } }
        expect(response).to redirect_to(new_supplier_path)
        expect(flash[:notice]).to eq("Supplier was successfully created.")
      end
    end


    context 'with invalid attributes' do
      it 'does not create a new supplier' do
        expect {
          post :create, params: { supplier: { name: nil, cnpj: nil } }
        }.to_not change(Supplier, :count)
      end

      it 'renders the new template again' do
        post :create, params: { supplier: { name: nil, cnpj: nil } }
        expect(response).to render_template(:new)
        expect(flash[:alert]).to eq("Supplier not created")
      end
    end
  end
end
