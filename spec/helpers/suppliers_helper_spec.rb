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
end
