require 'rails_helper'

RSpec.describe CardapioHelper, type: :helper do
  describe "#format_price" do
    it "formata o preço como moeda brasileira" do
      expect(helper.format_price(25.0)).to eq("R$25,00")
    end
  end
end
