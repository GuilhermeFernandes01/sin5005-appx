require 'rails_helper'

RSpec.describe SuppliersController, type: :controller do
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
          cnpj: '12345678000199',
          phone: '(11) 99999-9999',
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

describe "GET #index" do
  let!(:supplier1) { instance_double("Supplier", id: 1, name: 'Supplier 1', cnpj: '12345678901234', phone: '(11) 2345-6789', email: 'supplier1@test.com', segment: 'cheese', products: 'products', code: 'TET001') }
  let!(:supplier2) { instance_double("Supplier", id: 2, name: 'Supplier 2', cnpj: '23456789012345', phone: '(11) 2345-6788', email: 'supplier2@test.com', segment: 'sauce', products: 'other products', code: 'TET002') }
  before do
    allow(Supplier).to receive(:all).and_return([ supplier1, supplier2 ])
  end

  it "assigns all suppliers as @suppliers" do
    get :index
    expect(assigns(:suppliers)).to match_array([ supplier1, supplier2 ])
  end
end


 let!(:supplier) { Supplier.create!(name: 'Supplier Test', cnpj: '12345678901234', phone: '(11) 1234-5678', email: 'supplier@test.com', segment: 'cheese', products: 'Product A', code: 'SUP001') }

 describe 'DELETE #destroy' do
   it 'deletes the supplier and redirects to index' do
     expect {
       delete :destroy, params: { id: supplier.id }
     }.to change(Supplier, :count).by(-1)
     expect(response).to redirect_to(suppliers_path)
     expect(flash[:notice]).to eq("Supplier was successfully deleted.")
   end
 end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the supplier' do
        patch :update, params: { id: supplier.id, supplier: { name: 'Updated Supplier', phone: '(11) 09876-5431', email: 'updated@test.com', segment: 'Segment B', products: 'Product B' } }
        supplier.reload
        expect(supplier.name).to eq('Updated Supplier')
      end

      it 'redirects to the supplier show page' do
        patch :update, params: { id: supplier.id, supplier: { name: 'Updated Supplier' } }
        expect(response).to redirect_to(supplier_path(supplier))
      end

      it 'sets a flash message' do
        patch :update, params: { id: supplier.id, supplier: { name: 'Updated Supplier' } }
        expect(flash[:notice]).to eq("Supplier was successfully updated.")
      end
    end
  end
end
