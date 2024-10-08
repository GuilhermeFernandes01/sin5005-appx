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

  describe "GET #show" do
    let! (:mockProduct) { instance_double(Product, id: 1, name: 'Pizza de Pepperoni', price: 40.99, category: 'Pizza', require_ingredients: true) }

    context "valid product" do
      before(:each) do
        allow(Product).to receive(:find).and_return(mockProduct)
      end

      it "calls Product.find with the correct param" do
        get :show, params: { id: 1 }

        expect(Product).to have_received(:find).with('1')
      end

      it "assigns the correct product" do
        get :show, params: { id: 1 }

        expect(assigns(:product)).to eq(mockProduct)
      end

      it "renders the show template" do
        get :show, params: { id: 1 }

        expect(response).to render_template(:show)
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

  describe "GET #edit" do
    let! (:product) { instance_double(Product, id: 1, name: 'Pizza de Pepperoni', price: 40.99, category: 'Pizza', require_ingredients: true) }

    before(:each) do
      allow(Product).to receive(:find).and_return(product)
    end

    it "calls Product.find with the proper params" do
      get :edit, params: { id: 1 }

      expect(Product).to have_received(:find).with('1')
    end

    it "assigns the correct product" do
      get :edit, params: { id: 1 }

      expect(assigns(:product)).to eq(product)
    end

    it "should render the edit template" do
      get :edit, params: { id: 1 }

      expect(response).to render_template(:edit)
      expect(response.status).to eq(200)
    end
  end

  describe "PATCH #update" do
    let! (:product) { instance_double(Product, id: 1, name: 'Pizza de Pepperoni', price: 40.99, category: 'Pizza', require_ingredients: true) }

    before(:each) do
      allow(Product).to receive(:find).and_return(product)

      allow(product).to receive(:to_model).and_return(product)
      allow(product).to receive(:model_name).and_return(Product.model_name)
      allow(product).to receive(:persisted?).and_return(true)
    end

    context "with valid data" do
      before(:each) do
        allow(product).to receive(:update).and_return(true)
      end

      it "calls Product.find with the proper params" do
        patch :update, params: { id: 1, product: { name: 'Água', price: "1.99", category: 'Bebidas', require_ingredients: "false" } }

        expect(Product).to have_received(:find).with('1')
      end

      it "assigns the correct product" do
        product_params = { name: 'Água', price: "1.99", category: 'Bebidas', require_ingredients: "false" }
        patch :update, params: { id: 1, product: product_params }

        expect(assigns(:product)).to eq(product)
      end

      it "receives the new data" do
        product_params = { name: 'Água', price: "1.99", category: 'Bebidas', require_ingredients: "false" }
        patch :update, params: { id: 1, product: product_params }

        expect(product).to have_received(:update).with(ActionController::Parameters.new(product_params).permit(:name, :price, :category, :require_ingredients))
      end

      it "redirects to the product path" do
        product_params = { name: 'Água', price: "1.99", category: 'Bebidas', require_ingredients: "false" }
        patch :update, params: { id: 1, product: product_params }

        expect(response).to redirect_to(product_path(product))
      end
    end

    context "with invalid data" do
      before(:each) do
        allow(product).to receive(:update).and_return(false)
      end

      it "calls Product.find with the proper params" do
        patch :update, params: { id: 1, product: { name: "", price: "", category: 'Bebidas', require_ingredients: "false" } }

        expect(Product).to have_received(:find).with('1')
      end

      it "assigns the correct product" do
        product_params = { name: "", price: "", category: 'Bebidas', require_ingredients: "false" }
        patch :update, params: { id: 1, product: product_params }

        expect(assigns(:product)).to eq(product)
      end

      it "receives the new data" do
        product_params = { name: "", price: "", category: 'Bebidas', require_ingredients: "false" }
        patch :update, params: { id: 1, product: product_params }

        expect(product).to have_received(:update).with(ActionController::Parameters.new(product_params).permit(:name, :price, :category, :require_ingredients))
      end

      it "redirects to the product path" do
        product_params = { name: "", price: "", category: 'Bebidas', require_ingredients: "false" }
        patch :update, params: { id: 1, product: product_params }

        expect(response).to render_template(:edit)
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE #destroy" do
    let (:product) { instance_double(Product, id: 1, name: 'Pizza de Pepperoni', price: 40.99, category: 'Pizza', require_ingredients: true) }

    before(:each) do
      allow(Product).to receive(:find).and_return(product)

      allow(product).to receive(:destroy).and_return(product)
    end

    it "calls Product.find with the proper params" do
      delete :destroy, params: { id: 1 }

      expect(Product).to have_received(:find).with('1')
    end

    it "assings the correct product" do
      delete :destroy, params: { id: 1 }

      expect(assigns(:product)).to eq(product)
    end

    it "should destroy the product" do
      delete :destroy, params: { id: 1 }

      expect(product).to have_received(:destroy)
    end

    it "should redirect to the root products page" do
      delete :destroy, params: { id: 1 }

      expect(response).to redirect_to(products_path)
      expect(response.status).to eq(302)
    end
  end
end
