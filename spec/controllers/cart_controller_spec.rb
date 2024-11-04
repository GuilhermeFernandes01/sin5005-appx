require "rails_helper"

RSpec.describe CartController, type: :controller do
  let!(:cart) { Cart.new }
  let!(:generic_product) { create(:product) }

  describe "#set_cart" do
    let(:cart_double) { instance_double(Cart) }

    before(:each) do
      allow(Cart).to receive(:new).and_return(cart_double)
    end

    it "should assign a new cart" do
      controller.send(:set_cart)

      expect(assigns(:cart)).to eq(cart_double)
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
      allow(Cart).to receive(:new).and_return(cart)
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
        end

        it "should add the product to the cart" do
          post :add_product, params: { product_id: generic_product.id }

          expect(assigns(:cart).items).to match_array([ generic_product ])
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
        end

        it "should not add any product to cart" do
          post :add_product, params: { product_id: 1 }

          expect(assigns(:cart).items).to be_empty
        end

        it "should redirect to index with the proper alert" do
          post :add_product, params: { product_id: 1 }

          expect(response).to redirect_to(cart_index_path)
          expect(flash[:alert]).to eq("Produto não encontrado")
        end
      end
    end

    describe "DELETE #remove_product" do
      before(:each) do
        cart.items << generic_product
      end

      it "should call Product.find with the proper argument" do
        expect(Product).to receive(:find_by).with(id: "#{generic_product.id}")

        post :add_product, params: { product_id: generic_product.id }
      end

      context "valid product" do
        before(:each) do
          allow(Product).to receive(:find_by).and_return(generic_product)
        end

        it "should remove the product from the cart" do
          delete :remove_product, params: { product_id: generic_product.id }

          expect(assigns(:cart).items).to be_empty
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
        end

        it "should not remove any product from the cart" do
          delete :remove_product, params: { product_id: 1 }

          expect(cart.items).to match_array([ generic_product ])
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
