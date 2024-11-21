require 'rails_helper'

RSpec.describe CardapioController, type: :controller do
  describe "GET #index" do
    before do
      @category_a = "Pizza"
      @category_b = "Sobremesa"
      @product1 = Product.create!(name: "Margherita", price: 25.0, category: @category_a)
      @product2 = Product.create!(name: "Brownie", price: 15.0, category: @category_b)
    end

    it "retorna status 200" do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end
end
