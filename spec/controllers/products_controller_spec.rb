require "rails_helper"

RSpec.describe ProductsController, type: :controller do
  let!(:generic_product) { create(:product) }
  let!(:generic_ingredient) { create(:ingredient) }
  let!(:pepperoni_ingredient) { create(:ingredient, :pepperoni) }
  let!(:cheese_ingredient) { create(:ingredient, :cheese) }
  let!(:tomato_ingredient) { create(:ingredient, :tomato) }

  describe "GET #index" do
    context "there are registered products" do
      let (:product1) { create(:product, :pizza_pepperoni) }
      let (:product2) { create(:product, :water) }

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
    let! (:mockProduct) { create(:product, :pizza_pepperoni) }

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
    before(:each) do
      allow(Ingredient).to receive(:all).and_return([ generic_ingredient ])
    end

    it "assigns a new product to @product" do
      get :new

      expect(assigns(:product)).to be_a_new(Product)
    end

    it "assigns all the ingredients to @ingredients" do
      get :new

      expect(Ingredient).to have_received(:all)
      expect(assigns(:ingredients)).to match_array([ generic_ingredient ])
    end

    it "renders the new template" do
      get :new

      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    let!(:product) { create(:product, :pizza_pepperoni) }
    let!(:ingredients) { [ pepperoni_ingredient, cheese_ingredient, tomato_ingredient ] }

    context "with valid attributes" do
      before(:each) do
        allow(Product).to receive(:new).and_return(product)
        allow(Ingredient).to receive(:all).and_return(ingredients)
      end

      it "calls Product.new with the proper params" do
        product_params = { name: "Pizza de Pepperoni", price: "40.99", category: "Pizza" }
        post :create, params: { product: product_params }

        expect(Product).to have_received(:new).with(ActionController::Parameters.new(product_params).permit(:name, :price, :category))
      end

      it "calls #update_product_ingredients" do
        expect(controller).to receive(:update_product_ingredients)

        product_params = { name: "Pizza de Pepperoni", price: "40.99", category: "Pizza" }
        post :create, params: { product: product_params }
      end

      context "with ingredient_ids" do
        let!(:assign_ingredients) { [ pepperoni_ingredient, cheese_ingredient ] }

        before(:each) do
          allow(Ingredient).to receive(:find).and_return(assign_ingredients)
        end

        it "should have assigned the correct ingredients to the product" do
          product_params = { name: "Pizza de Pepperoni", price: "40.99", category: "Pizza" }
          post :create, params: { product: product_params, ingredient_ids: assign_ingredients.map(&:id) }

          expect(assigns(:product).ingredients).to match_array(assign_ingredients)
        end
      end

      context "without ingredient_ids" do
        it "should have no ingredients" do
          product_params = { name: "Água", price: "1.99", category: "Bebidas" }
          post :create, params: { product: product_params }

          expect(assigns(:product).ingredients).to be_empty
        end
      end

      it "redirects to the product path" do
        post :create, params: { product: { name: "Pizza de Pepperoni", price: "40.99", category: "Pizza", require_ingredients: "true" } }
        expect(response).to redirect_to(product_path(product))
      end
    end

    context "with invalid attributes" do
      before do
        allow(product).to receive(:save).and_return(false)
        allow(Ingredient).to receive(:all).and_return(ingredients)
      end

      it "assigns the ingredients" do
        post :create, params: { product: { name: "" } }

        expect(assigns(:ingredients)).to match_array(ingredients)
      end

      it "renders the new template with the unprocessable entity status" do
        post :create, params: { product: { name: "" } }
        expect(response).to render_template(:new)
        expect(response.status).to eq(422)
      end
    end
  end

  describe "GET #edit" do
    before(:each) do
      allow(Product).to receive(:find).and_return(generic_product)
      allow(Ingredient).to receive(:all).and_return([ generic_ingredient ])
    end

    it "calls Product.find with the proper params" do
      get :edit, params: { id: 1 }

      expect(Product).to have_received(:find).with('1')
    end

    it "assigns the correct product" do
      get :edit, params: { id: 1 }

      expect(assigns(:product)).to eq(generic_product)
    end

    it "assigns all the ingredients to @ingredients" do
      get :edit, params: { id: 1 }

      expect(Ingredient).to have_received(:all)
      expect(assigns(:ingredients)).to match_array([ generic_ingredient ])
    end

    it "should render the edit template" do
      get :edit, params: { id: 1 }

      expect(response).to render_template(:edit)
      expect(response.status).to eq(200)
    end
  end

  describe "PATCH #update" do
    let! (:product) { create(:product, :pizza_pepperoni) }
    let!(:ingredients) { [ pepperoni_ingredient, cheese_ingredient, tomato_ingredient ] }

    before(:each) do
      allow(Product).to receive(:find).and_return(product)
    end

    context "with valid data" do
      before(:each) do
        allow(product).to receive(:update).and_return(true)
      end

      it "calls Product.find with the proper params" do
        patch :update, params: { id: 1, product: { name: 'Água', price: "1.99", category: 'Bebidas' } }

        expect(Product).to have_received(:find).with('1')
      end

      it "calls #update_product_ingredients" do
        expect(controller).to receive(:update_product_ingredients)

        patch :update, params: { id: 1, product: { name: 'Água', price: "1.99", category: 'Bebidas' } }
      end

      context "with ingredient_ids" do
        let!(:assign_ingredients) { [ pepperoni_ingredient, cheese_ingredient ] }

        before(:each) do
          allow(Ingredient).to receive(:find).and_return(assign_ingredients)
        end

        it "should have assigned the correct ingredients to the product" do
          patch :update, params: { id: 1, product: { name: 'Pizza de Pepperoni', price: "40.99", category: 'Pizza' }, ingredient_ids: assign_ingredients.map(&:id) }

          expect(assigns(:product).ingredients).to match_array(assign_ingredients)
        end
      end

      context "without ingredient_ids" do
        it "should have no ingredients" do
          patch :update, params: { id: 1, product: { name: 'Água', price: "1.99", category: 'Bebidas' } }

          expect(assigns(:product).ingredients).to be_empty
        end
      end

      it "assigns the correct product" do
        product_params = { name: 'Água', price: "1.99", category: 'Bebidas' }
        patch :update, params: { id: 1, product: product_params }

        expect(assigns(:product)).to eq(product)
      end

      it "receives the new data" do
        product_params = { name: 'Água', price: "1.99", category: 'Bebidas' }
        patch :update, params: { id: 1, product: product_params }

        expect(product).to have_received(:update).with(ActionController::Parameters.new(product_params).permit(:name, :price, :category))
      end

      it "redirects to the product path" do
        product_params = { name: 'Água', price: "1.99", category: 'Bebidas' }
        patch :update, params: { id: 1, product: product_params }

        expect(response).to redirect_to(product_path(product))
      end
    end

    context "with invalid data" do
      before(:each) do
        allow(product).to receive(:update).and_return(false)
      end

      it "calls Product.find with the proper params" do
        patch :update, params: { id: 1, product: { name: "", price: "", category: 'Bebidas' } }

        expect(Product).to have_received(:find).with('1')
      end

      it "assigns the correct product" do
        product_params = { name: "", price: "", category: 'Bebidas' }
        patch :update, params: { id: 1, product: product_params }

        expect(assigns(:product)).to eq(product)
      end

      it "receives the new data" do
        product_params = { name: "", price: "", category: 'Bebidas' }
        patch :update, params: { id: 1, product: product_params }

        expect(product).to have_received(:update).with(ActionController::Parameters.new(product_params).permit(:name, :price, :category))
      end

      it "redirects to the product path" do
        product_params = { name: "", price: "", category: 'Bebidas' }
        patch :update, params: { id: 1, product: product_params }

        expect(response).to render_template(:edit)
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE #destroy" do
    let (:product) { create(:product, :pizza_pepperoni) }

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

  describe "#product_params" do
    it "permits valid params" do
      valid_params = ActionController::Parameters.new({ product: { name: 'Product A', price: 100, category: 'Category A' } })

      controller.params = valid_params
      expect(controller.send(:product_params)).to eq(valid_params[:product].permit(:name, :price, :category))
    end

    it "doesn't permit invalid params" do
      invalid_params = ActionController::Parameters.new({ product: { name: 'Product B', price: 100, category: 'Category B', invalid: 'Invalid' } })

      controller.params = invalid_params
      expect(controller.send(:product_params)).to eq(invalid_params[:product].permit(:name, :price, :category))
    end
  end

  describe "#update_product_ingredients" do
    before(:each) do
      controller.instance_variable_set(:@product, generic_product)
    end

    context "with ingredient_ids provided" do
      let!(:ingredient_ids) { [ pepperoni_ingredient.id, cheese_ingredient.id ] }

      before(:each) do
        allow(Ingredient).to receive(:find).and_return([ pepperoni_ingredient, cheese_ingredient ])
        allow(controller).to receive(:params).and_return({ ingredient_ids: ingredient_ids })
      end

      it "should update the @product ingredients" do
        controller.send(:update_product_ingredients)

        expect(Ingredient).to have_received(:find).with(ingredient_ids)
        expect(assigns(:product).ingredients).to match_array([ pepperoni_ingredient, cheese_ingredient ])
      end
    end

    context "without ingredient_ids provided" do
      before(:each) do
        allow(controller).to receive(:params).and_return({})
        assigns(:product).ingredients << generic_ingredient
      end

      it "should call clear on the @product ingredients" do
        expect(assigns(:product).ingredients).to receive(:clear)

        controller.send(:update_product_ingredients)
      end

      it "should leave the @products ingredients empty" do
        controller.send(:update_product_ingredients)

        expect(assigns(:product).ingredients).to be_empty
      end
    end
  end
end
