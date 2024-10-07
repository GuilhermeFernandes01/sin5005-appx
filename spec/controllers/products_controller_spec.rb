require "rails_helper"

RSpec.describe ProductsController, type: :controller do
  let(:product) { instance_double(Product) }

  describe "GET #index" do
    context "there are registered products" do
      let (:product1) { instance_double(Product, name: 'Pizza de Pepperoni', price: 40.99, category: 'Pizza', require_ingredients: true) }
      let (:product2) { instance_double(Product, name: 'Água', price: 1.99, category: 'Bebidas', require_ingredients: false) }

      before(:each) do
        allow(Product).to receive(:all).and_return([ product1, product2 ])
      end

      it "assigns the products" do
        get :index
        expect(assigns(:products)).to eq([ product1, product2 ])
      end

      it "renders the correct view" do
        get :index
        expect(response).to render_template(:index)
      end
    end

    context "there are no registered products" do
      before(:each) do
        allow(Product).to receive(:all).and_return([])
      end

      it "assigns the products" do
        get :index
        expect(assigns(:products)).to eq([])
      end

      it "renders the correct view" do
        get :index
        expect(response).to render_template(:index)
      end
    end
  end

  describe "GET #new" do
    it "assigns a new product to @product" do
      get :new

      expect(assigns(:product)).to be_a_new(Product)
    end

    it "renders the new template" do
      get :new

      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before do
        allow(product).to receive(:save).and_return(true)
      end

      it "redirects to the root path" do
        post :create, params: { product: { name: "Pizza de Pepperoni", price: 40.99, category: "Pizza", require_ingredients: true } }
        expect(response).to redirect_to("/products/new")
      end
    end

    context "with invalid attributes" do
      before do
        allow(product).to receive(:save).and_return(false)
      end

      it "renders the new template with the unprocessable entity status" do
        post :create, params: { product: { require_ingredients: false } }
        expect(response).to render_template(:new)
        expect(response.status).to eq(422)
      end
    end
  end
end
