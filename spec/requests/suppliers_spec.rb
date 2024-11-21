require 'rails_helper'

RSpec.describe "Supplier", type: :request do
 describe "GET /supplier/new" do
   it "renders the new supplier form" do
     get new_supplier_path
     expect(response).to have_http_status(:ok)
     expect(response.body).to include("Criar fornecedor")
   end
 end

 describe "POST /supplier" do
   context "with valid parameters" do
     it "creates a new supplier" do
       post suppliers_path, params: { supplier: { name: "Supplier 1", cnpj: "12345678000123", segment: "Segment A", products: "Product A" } }
       expect(response).to redirect_to(new_supplier_path)
       follow_redirect!
       expect(response.body).to include("Fornecedor foi criado com sucesso.")
     end
   end

   context "with invalid parameters" do
     it "does not create a new supplier and re-renders the form" do
       post suppliers_path, params: { supplier: { name: nil, cnpj: nil } }
       expect(response).to have_http_status(:unprocessable_entity)
       expect(response.body).to include("Fornecedor não foi criado")
     end
   end
 end


   describe "DELETE /suppliers/:id" do
     let!(:supplier) { create(:supplier) }

     context "when confirming deletion" do
       it "deletes the supplier and redirects to index" do
         delete supplier_path(supplier), params: { confirm: 'true' }
         expect(response).to redirect_to(suppliers_path)
         follow_redirect!
         expect(response.body).to include("Fornecedor foi excluído com sucesso.")
       end
     end

     context "when deletion fails" do
       before do
         allow_any_instance_of(Supplier).to receive(:destroy).and_return(false)
       end

       it "does not delete the supplier and redirects to index without an error message" do
         delete supplier_path(supplier), params: { confirm: 'true' }
         expect(response).to redirect_to(suppliers_path)
         follow_redirect!
         expect(response.body).not_to include("Fornecedor foi excluído com sucesso.")
       end
     end
     context "when deletion is cancelled" do
      it "does not delete the supplier and redirects to index without any message" do
        allow_any_instance_of(Supplier).to receive(:destroy).and_return(false)

        expect {
          delete supplier_path(supplier), params: { confirm: 'false' }
        }.not_to change(Supplier, :count)

        expect(response).to redirect_to(suppliers_path)
        follow_redirect!
        expect(response.body).not_to include("Fornecedor foi excluído com sucesso.")
      end
    end
   end





  describe "PATCH /suppliers/:id" do
  let!(:supplier) { create(:supplier) }

    it "updates the supplier" do
      patch supplier_path(supplier), params: { supplier: { name: 'Updated Supplier', cnpj: "12345678000123", phone: '(11) 09876-4321', email: 'updated@test.com', segment: 'Segment B', products: 'Product B' } }
      expect(supplier.reload.name).to eq('Updated Supplier')
      expect(response).to redirect_to(supplier_path(supplier))
      follow_redirect!
      expect(response.body).to include("Fornecedor foi atualizado com sucesso.")
    end
  end

    describe "GET /suppliers" do
      let!(:supplier1) { Supplier.create!(code: 'SUP001', name: 'Supplier One', cnpj: "12345678000121", phone: '(11) 12345-7890', email: 'supplier1@test.com', segment: 'Segment A', products: 'Product A') }
      let!(:supplier2) { Supplier.create!(code: 'SUP002', name: 'Supplier Two', cnpj: "12345678000122", phone: '(11) 12345-7890', email: 'supplier1@test.com', segment: 'Segment B', products: 'Product B') }
      let!(:supplier3) { Supplier.create!(code: 'SUP003', name: 'Supplier Three', cnpj: "12345678000123", phone: '(11) 12345-7890', email: 'supplier1@test.com', segment: 'Segment A', products: 'Product C') }

      context 'when no search parameters are provided' do
        it 'returns all suppliers' do
          get suppliers_path
          expect(assigns(:suppliers)).to match_array([ supplier1, supplier2, supplier3 ])
        end
      end

      context 'when searching by code' do
        it 'returns suppliers matching the code' do
          get suppliers_path, params: { search_by_code: 'SUP001' }
          expect(assigns(:suppliers)).to match_array([ supplier1 ])
        end
      end

      context 'when searching by name' do
        it 'returns suppliers matching the name' do
          get suppliers_path, params: { search_by_name: 'Supplier Two' }
          expect(assigns(:suppliers)).to match_array([ supplier2 ])
        end
      end

      context 'when searching by segment' do
        it 'returns suppliers matching the segment' do
          get suppliers_path, params: { search_by_segment: 'Segment A' }
          expect(assigns(:suppliers)).to match_array([ supplier1, supplier3 ])
        end
      end

      context 'when searching by products' do
        it 'returns suppliers matching the products' do
          get suppliers_path, params: { search_by_products: 'Product B' }
          expect(assigns(:suppliers)).to match_array([ supplier2 ])
        end
      end
    end
  end
