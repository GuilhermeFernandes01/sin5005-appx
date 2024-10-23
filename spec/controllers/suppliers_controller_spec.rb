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
    let(:supplier_attributes) { attributes_for(:supplier) }

    it 'creates a new supplier' do
      expect {
        post :create, params: { supplier: supplier_attributes }
      }.to change(Supplier, :count).by(1)
    end

    it 'redirects to the supplier index path' do
      post :create, params: { supplier: supplier_attributes }
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

  describe 'GET #index' do
  let!(:supplier1) { Supplier.create!(name: 'Supplier One', cnpj: '12345678901200', phone: '(11) 2345-6789', email: 'supplier1@test.com', segment: 'Segment A', products: 'Product A', code: 'SUP001') }
  let!(:supplier2) { Supplier.create!(name: 'Supplier Two', cnpj: '23456789012345', phone: '(11) 2345-6788', email: 'supplier2@test.com', segment: 'Segment B', products: 'Product B', code: 'SUP002') }
  let!(:supplier3) { Supplier.create!(name: 'Supplier Three', cnpj: '34567890123456', phone: '(11) 2345-6787', email: 'supplier3@test.com', segment: 'Segment A', products: 'Product C', code: 'SUP003') }

    context 'when no search parameter is provided' do
      it "assigns all suppliers as @suppliers" do
        get :index
        expect(assigns(:suppliers)).to match_array([ supplier1, supplier2, supplier3 ])
      end
    end

    context 'when searching by code' do
      it 'returns suppliers matching the code' do
        get :index, params: { search_by_code: 'SUP001' }
        expect(assigns(:suppliers)).to match_array([ supplier1 ])
      end
    end

    context 'when searching by name' do
      it 'returns suppliers matching the name' do
        get :index, params: { search_by_name: 'Supplier One' }
        expect(assigns(:suppliers)).to match_array([ supplier1 ])
      end
    end

    context 'when searching by segment' do
      it 'returns suppliers matching the segment' do
        get :index, params: { search_by_segment: 'Segment A' }
        expect(assigns(:suppliers)).to match_array([ supplier1, supplier3 ])
      end
    end

    context 'when searching by products' do
      it 'returns suppliers matching the products' do
        get :index, params: { search_by_products: 'Product A' }
        expect(assigns(:suppliers)).to match_array([ supplier1 ])
      end
    end

    context 'with search parameters' do
      let(:valid_params) do
        {
          search_by_code: 'SUP001',
          search_by_name: 'Supplier One',
          search_by_segment: 'Segment A',
          search_by_products: 'Product A'
        }
      end

      let(:invalid_params) do
        {
          search_by_code: 'SUP001',
          search_by_name: 'Supplier One',
          invalid_param: 'Invalid'
        }
      end

      it 'permits valid search parameters' do
        get :index, params: valid_params
        expect(controller.send(:search_params)).to include(:search_by_code, :search_by_name, :search_by_segment, :search_by_products)
      end

      it 'does not permit invalid parameters' do
        get :index, params: invalid_params
        expect(controller.send(:search_params)).not_to include(:invalid_param)
      end
    end
  end

    describe "DELETE #destroy" do
      let!(:supplier) { create(:supplier) }

      it "deletes the supplier and redirects to suppliers_path" do
        expect {
          delete :destroy, params: { id: supplier.id }
        }.to change(Supplier, :count).by(-1)
        expect(response).to redirect_to(suppliers_path)
        expect(flash[:notice]).to eq("Supplier was successfully deleted.")
      end

      it "does not set flash notice if supplier deletion fails" do
        allow_any_instance_of(Supplier).to receive(:destroy).and_return(false)

        delete :destroy, params: { id: supplier.id }

        expect(response).to redirect_to(suppliers_path)
        expect(flash[:notice]).to be_nil
      end
    end

  describe 'PATCH #update' do
    let!(:supplier) { create(:supplier) }
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

    context 'with invalid attributes' do
      it 'does not update the supplier' do
        patch :update, params: { id: supplier.id, supplier: { name: nil, email: 'invalidemail' } }
        supplier.reload
        expect(supplier.name).not_to eq(nil)
      end

      it 'renders the edit template again' do
        patch :update, params: { id: supplier.id, supplier: { name: nil, email: 'invalidemail' } }
        expect(response).to render_template(:edit)
      end

      it 'sets a flash message' do
        patch :update, params: { id: supplier.id, supplier: { name: nil } }
        expect(flash[:alert]).to eq("Supplier could not be updated, please consider the informations sent")
      end
    end
  end

  describe 'GET #show' do
    let!(:supplier) { create(:supplier) }
    it 'assigns the requested supplier to @supplier' do
      get :show, params: { id: supplier.id }
      expect(assigns(:supplier)).to eq(supplier)
    end

    it 'renders the show template' do
      get :show, params: { id: supplier.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #edit' do
    let!(:supplier) { create(:supplier) }
    it 'assigns the requested supplier to @supplier' do
      get :edit, params: { id: supplier.id }
      expect(assigns(:supplier)).to eq(supplier)
    end

    it 'renders the edit template' do
      get :edit, params: { id: supplier.id }
      expect(response).to render_template(:edit)
    end
  end
end
