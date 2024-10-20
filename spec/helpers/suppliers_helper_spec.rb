require 'rails_helper'

RSpec.describe SuppliersHelper, type: :helper do
describe "#format_products" do
  it "returns a formatted string of products" do
    expect(helper.format_products([ 'Product A', 'Product B' ])).to eq("Product A, Product B")
  end

  it "returns an empty string when products is empty" do
    expect(helper.format_products([])).to eq("")
  end
end

describe "#format_supplier_code" do
  let(:supplier) { Supplier.new(name: 'Supplier 1', cnpj: '12345678901234', phone: '(11) 1234-5678', email: 'supplier1@test.com', segment: 'cheese', products: 'products', code: '00N') }

  it "returns the code in a formatted style" do
    expect(helper.format_supplier_code(supplier)).to eq("Supplier Code: 00N")
  end
end

 describe "#format_supplier_name" do
   let(:supplier) { Supplier.new(name: 'Supplier Test', code: 'SUP_TXX0') }

   it "returns a formatted string with the supplier name and code" do
     expect(helper.format_supplier_name(supplier)).to eq("Supplier Test (SUP_TXX0)")
   end
 end

  describe "#format_phone" do
    it "formats a 10-digit phone number correctly" do
      expect(helper.format_phone("1198765432")).to eq("(11) 9876-5432")
    end

    it "formats an 11-digit phone number correctly" do
      expect(helper.format_phone("11987654321")).to eq("(11) 98765-4321")
    end

    it "returns the original input for non-10/11-digit numbers" do
      expect(helper.format_phone("123456")).to eq("123456")
    end

    it "ignores non-digit characters" do
      expect(helper.format_phone("(11) 98765-4321")).to eq("(11) 98765-4321")
    end
  end
end
