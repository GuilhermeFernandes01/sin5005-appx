require 'rails_helper'

RSpec.describe "Supplier", type: :request do
 describe "GET /supplier/new" do
   it "renders the new supplier form" do
     get new_supplier_path
     expect(response).to have_http_status(:ok)
     expect(response.body).to include("Criar Fornecedor")
   end
 end

 describe "POST /supplier" do
   context "with valid parameters" do
     it "creates a new supplier" do
       post suppliers_path, params: { supplier: { name: "Supplier 1", cnpj: "12345678000123", segment: "Segment A", products: "Product A" } }
       expect(response).to redirect_to(new_supplier_path)
       follow_redirect!
       expect(response.body).to include("Supplier was successfully created.")
     end
   end

   context "with invalid parameters" do
     it "does not create a new supplier and re-renders the form" do
       post suppliers_path, params: { supplier: { name: nil, cnpj: nil } }
       expect(response).to have_http_status(:unprocessable_entity)
       expect(response.body).to include("Supplier not created")
     end
   end
 end

  describe "DELETE /suppliers/:id" do
    let!(:supplier) { Supplier.create!(name: "Supplier 1", cnpj: "12345678000123", segment: "Segment A", products: "Product A") }

    it "deletes the supplier and redirects to index" do
      delete supplier_path(supplier)
      expect(response).to redirect_to(suppliers_path)
      follow_redirect!
      expect(response.body).to include("Supplier was successfully deleted.")
  end
end

  describe "PATCH /suppliers/:id" do
    let!(:supplier) { Supplier.create!(name: 'Supplier 1', cnpj: "12345678000123", phone: '(11) 12345-7890', email: 'supplier1@test.com', segment: 'Segment A', products: 'Product A') }

    it "updates the supplier" do
      patch supplier_path(supplier), params: { supplier: { name: 'Updated Supplier', cnpj: "12345678000123", phone: '(11) 09876-4321', email: 'updated@test.com', segment: 'Segment B', products: 'Product B' } }
      expect(supplier.reload.name).to eq('Updated Supplier')
      expect(response).to redirect_to(supplier_path(supplier))
      follow_redirect!
      expect(response.body).to include("Supplier was successfully updated.")
    end
  end
end
