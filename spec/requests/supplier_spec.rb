RSpec.describe "Supplier", type: :request do
  describe "GET /supplier" do
    let!(:supplier1) { Supplier.create!(name: 'Supplier 1', cnpj: '12345678000123', phone: '(11) 1234-5678', email: 'supplier1@test.com', segment: 'Segment A', products: 'Product A', code: 'SUP001') }
    let!(:supplier2) { Supplier.create!(name: 'Supplier 2', cnpj: '23456789000123', phone: '(11) 9876-5432', email: 'supplier2@test.com', segment: 'Segment B', products: 'Product B', code: 'SUP002') }

    it "returns a list of suppliers" do
      get supplier_index_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('Supplier 1')
      expect(response.body).to include('12345678000123')
      expect(response.body).to include('Supplier 2')
      expect(response.body).to include('23456789000123')
    end
  end

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
        post supplier_index_path, params: { supplier: { name: "Supplier 1", cnpj: "12345678000123", segment: "Segment A", products: "Product A" } }
        expect(response).to redirect_to(new_supplier_path)
        follow_redirect!
        expect(response.body).to include("Supplier was successfully created.")
      end
    end

    context "with invalid parameters" do
      it "does not create a new supplier and re-renders the form" do
        post supplier_index_path, params: { supplier: { name: nil, cnpj: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("Supplier not created")
      end
    end
  end
end
