require 'rails_helper'

RSpec.describe SupplierHelper, type: :helper do
  describe "#format_products" do
    it "returns a formatted string of products" do
      expect(helper.format_products(['Product A', 'Product B'])).to eq("Product A, Product B")
    end

    it "returns an empty string when products is empty" do
      expect(helper.format_products([])).to eq("")
    end
  end
end
