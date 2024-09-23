require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "GET #new" do
    it "returns http success" do
      get "/products/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    let(:product) { instance_double(Product) }

    context "with valid attributes" do
      before do
        allow(product).to receive(:save).and_return(true)
      end

      it "redirects to the root path" do
        post "/products", params: { product: { name: "Pizza de Pepperoni", price: 40.99, category: "Pizza", require_ingredients: true } }
        expect(response).to redirect_to("/products/new")
      end
    end

    context "with invalid attributes" do
      let(:product) { instance_double(Product) }

      before do
        allow(product).to receive(:save).and_return(false)
      end

      it "renders the new template with the unprocessable entity status" do
        post "/products", params: { product: { require_ingredients: false } }
        expect(response).to render_template(:new)
        expect(response.status).to eq(422)
      end
    end
  end
end
