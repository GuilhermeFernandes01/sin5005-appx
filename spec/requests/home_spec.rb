require 'rails_helper'

RSpec.describe "Home Page", type: :request do
  describe "GET /" do
    it "renders the home page successfully" do
      get root_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Bem-vindo à Pizzaria EACH")
    end
  end
end
