require "rails_helper"

RSpec.describe OrdersController, type: :controller do
  let(:generic_order) { create(:order) }

  describe "GET #index" do
    before(:each) do
      allow(Order).to receive(:all).and_return([ generic_order ])
    end

    it "assigns the orders" do
      get :index
      expect(assigns(:orders)).to eq([ generic_order ])
    end

    it "renders the correct view" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "POST #create" do
    let!(:product) { create(:product, :pizza_pepperoni) }

    context "with valid attributes" do
      before(:each) do
        allow(Order).to receive(:new).and_return(generic_order)
        allow(generic_order).to receive(:save).and_return(true)
        allow(Product).to receive(:find_by!).with(id: "#{product.id}").and_return(product)
      end

      it "calls Order.new with the proper params" do
        order_params = { customer_name: "José" }
        product_ids = [ product.id ]
        post :create, params: { order: order_params, product_ids: product_ids }

        expect(Order).to have_received(:new).with(ActionController::Parameters.new(order_params).permit(:customer_name))
      end

      it "should call Product.find_by! with the proper parameters" do
        order_params = { customer_name: "José" }
        product_ids = [ product.id ]
        post :create, params: { order: order_params, product_ids: product_ids }

        product_ids.each do |id|
          expect(Product).to have_received(:find_by!).with(id: "#{id}")
        end
      end

      it "should assign the products to the order" do
        order_params = { customer_name: "José" }
        product_ids = [ product.id ]
        post :create, params: { order: order_params, product_ids: product_ids }

        expect(assigns(:order).products).to match_array([ product ])
      end

      it "redirects to the orders path with the proper notice and clean the session" do
        session[:cart] = [ product.id ]
        order_params = { customer_name: "José" }
        product_ids = [ product.id ]
        post :create, params: { order: order_params, product_ids: product_ids }

        expect(response).to redirect_to(orders_path)
        expect(flash[:notice]).to eq("Pedido foi criado com sucesso!")
        expect(session[:cart]).to be_nil
      end
    end

    context "with invalid attributes" do
      before(:each) do
        allow(Order).to receive(:new).and_return(generic_order)
        allow(generic_order).to receive(:save).and_return(false)
        allow(Product).to receive(:find_by!).with(id: "#{product.id}").and_return(product)
      end

      it "calls Order.new with the proper params" do
        order_params = { customer_name: "" }
        product_ids = [ product.id ]
        post :create, params: { order: order_params, product_ids: product_ids }

        expect(Order).to have_received(:new).with(ActionController::Parameters.new(order_params).permit(:customer_name))
      end

      it "should redirect to the cart index page with the proper alert" do
        order_params = { customer_name: "" }
        product_ids = [ product.id ]
        post :create, params: { order: order_params, product_ids: product_ids }

        expect(response).to redirect_to(cart_index_path)
        expect(response.status).to eq(302)
        expect(flash[:alert]).to eq("Erro ao criar o pedido!")
      end
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      allow(Order).to receive(:find).and_return(generic_order)

      allow(generic_order).to receive(:destroy).and_return(generic_order)
    end

    it "calls Order.find with the proper params" do
      delete :destroy, params: { id: 1 }

      expect(Order).to have_received(:find).with('1')
    end

    it "assings the correct order" do
      delete :destroy, params: { id: 1 }

      expect(assigns(:order)).to eq(generic_order)
    end

    it "should destroy the order" do
      delete :destroy, params: { id: 1 }

      expect(generic_order).to have_received(:destroy)
    end

    it "should redirect to the root orders page" do
      delete :destroy, params: { id: 1 }

      expect(response).to redirect_to(orders_path)
      expect(response.status).to eq(302)
    end
  end
end
