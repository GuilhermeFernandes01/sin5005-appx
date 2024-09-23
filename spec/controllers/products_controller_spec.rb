require "rails_helper"

RSpec.describe ProductsController, type: :controller do
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
end
