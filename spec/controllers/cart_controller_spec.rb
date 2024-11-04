require "rails_helper"

RSpec.describe CartController, type: :controller do
  let!(:cart) { Cart.new }
  let!(:generic_product) { create(:product) }
  let!(:pizza_product) { create(:product, :pizza_pepperoni) }
  let!(:water_product) { create(:product, :water) }

  describe "#set_cart" do
    let(:cart_double) { instance_double(Cart) }

    it "should assign a new cart" do
      allow(Cart).to receive(:new).and_return(cart_double)

      controller.send(:set_cart)

      expect(assigns(:cart)).to eq(cart_double)
    end

    context "there are products in the session" do
      before(:each) do
        allow(Cart).to receive(:new).and_return(cart)

        session[:cart] = [ pizza_product.id, water_product.id ]

        allow(Product).to receive(:find).with(pizza_product.id).and_return(pizza_product)
        allow(Product).to receive(:find).with(water_product.id).and_return(water_product)
      end

      it "should search for each product id" do
        controller.send(:set_cart)

        expect(Product).to have_received(:find).with(pizza_product.id)
        expect(Product).to have_received(:find).with(water_product.id)
      end

      it "should have created a cart with the products" do
        controller.send(:set_cart)

        expect(assigns(:cart).items).to match_array([ pizza_product, water_product ])
      end
    end

    context "there are no products in the session" do
      before(:each) do
        allow(Cart).to receive(:new).and_return(cart)

        session[:cart] = nil
      end

      it "should not search for any product" do
        expect(Product).not_to receive(:find)

        controller.send(:set_cart)
      end

      it "should have created a cart without any product" do
        controller.send(:set_cart)

        expect(assigns(:cart).items).to be_empty
      end
    end
  end

  describe "GET #index" do
    let(:cart_double) { instance_double(Cart) }

    before(:each) do
      allow(Cart).to receive(:new).and_return(cart_double)
    end

    it "should have an instance of Cart in @cart" do
      get :index

      expect(assigns(:cart)).to eq(cart_double)
    end

    it "should render the index template" do
      get :index

      expect(response).to render_template(:index)
    end
  end

  context "add and remove from cart" do
    before(:each) do
      allow(controller).to receive(:set_cart)
      controller.instance_variable_set(:@cart, cart)
    end

    describe "POST #add_product" do
      it "should call Product.find with the proper argument" do
        expect(Product).to receive(:find_by).with(id: "#{generic_product.id}")

        post :add_product, params: { product_id: generic_product.id }
      end

      context "valid product" do
        before(:each) do
          allow(Product).to receive(:find_by).and_return(generic_product)
          cart.items = []
          session[:cart] = []
        end

        it "should add the product to the cart" do
          post :add_product, params: { product_id: generic_product.id }

          expect(assigns(:cart).items).to match_array([ generic_product ])
        end

        it "should update the session cart" do
          post :add_product, params: { product_id: generic_product.id }

          expect(session[:cart]).to match_array([ generic_product.id ])
        end

        it "should redirect to index with the proper notice" do
          post :add_product, params: { product_id: generic_product.id }

          expect(response).to redirect_to(cart_index_path)
          expect(flash[:notice]).to eq("#{generic_product.name} foi adicionado ao carrinho.")
        end
      end

      context "invalid product" do
        before(:each) do
          allow(Product).to receive(:find_by).and_return(nil)
          cart.items = []
          session[:cart] = []
        end

        it "should not add any product to cart" do
          post :add_product, params: { product_id: 1 }

          expect(assigns(:cart).items).to be_empty
        end

        it "should not update the session cart" do
          post :add_product, params: { product_id: 1 }

          expect(session[:cart]).to be_empty
        end

        it "should redirect to index with the proper alert" do
          post :add_product, params: { product_id: 1 }

          expect(response).to redirect_to(cart_index_path)
          expect(flash[:alert]).to eq("Produto não encontrado")
        end
      end
    end

    describe "DELETE #remove_product" do
      it "should call Product.find with the proper argument" do
        expect(Product).to receive(:find_by).with(id: "#{generic_product.id}")

        delete :remove_product, params: { product_id: generic_product.id }
      end

      context "valid product" do
        before(:each) do
          allow(Product).to receive(:find_by).and_return(generic_product)
          cart.items << generic_product
          session[:cart] = [ generic_product.id ]
        end

        it "should remove the product from the cart" do
          delete :remove_product, params: { product_id: generic_product.id }

          expect(assigns(:cart).items).to be_empty
        end

        it "should update the session cart" do
          delete :remove_product, params: { product_id: generic_product.id }

          expect(session[:cart]).to be_empty
        end

        it "should redirect to index with the proper notice" do
          delete :remove_product, params: { product_id: generic_product.id }

          expect(response).to redirect_to(cart_index_path)
          expect(flash[:notice]).to eq("#{generic_product.name} foi removido do carrinho.")
        end
      end

      context "invalid product" do
        before(:each) do
          allow(Product).to receive(:find_by).and_return(nil)
          cart.items << generic_product
          session[:cart] = [ generic_product.id ]
        end

        it "should not remove any product from the cart" do
          delete :remove_product, params: { product_id: 1 }

          expect(cart.items).to match_array([ generic_product ])
        end

        it "should not update the session cart" do
          delete :remove_product, params: { product_id: 1 }

          expect(session[:cart]).to match_array([ generic_product.id ])
        end

        it "should redirect to index with the proper alert" do
          delete :remove_product, params: { product_id: 1 }

          expect(response).to redirect_to(cart_index_path)
          expect(flash[:alert]).to eq("Produto não encontrado")
        end
      end
    end
  end
end
