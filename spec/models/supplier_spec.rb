require "rails_helper"

RSpec.describe Supplier, type: :model do
  context 'validations' do
    it 'is invalid without a name' do
      supplier = Supplier.new(name: nil)
      expect(supplier).to_not be_valid
    end

    it 'is invalid without a CNPJ' do
      supplier = Supplier.new(cnpj: nil)
      expect(supplier).to_not be_valid
    end

    it 'is invalid with a duplicate CNPJ' do
      Supplier.create!(name: 'Supplier 1', cnpj: '12345678000123', segment: 'Segment A', products: 'Product A')
      supplier = Supplier.new(name: 'Supplier 2', cnpj: '12345678000123', segment: 'Segment B', products: 'Product B')
      expect(supplier).to_not be_valid
    end

    it 'is invalid without products' do
      supplier = Supplier.new(name: 'Supplier 1', cnpj: '12345678000123', segment: 'Segment A', products: nil)
      expect(supplier).to_not be_valid
      expect(supplier.errors[:products]).to include("can't be blank")
    end

    it 'is invalid with duplicate products for the same supplier' do
      supplier = Supplier.create!(name: 'Supplier 1', cnpj: '12345678000123', segment: 'Segment A', products: 'Product A, Product B')
      supplier.products = 'Product A, Product A'
      expect(supplier).to_not be_valid
      expect(supplier.errors[:products]).to include("can't be duplicated products")
    end

    it 'is valid with unique products' do
      supplier = Supplier.new(name: 'Supplier 1', cnpj: '12345678000123', segment: 'Segment A', products: 'Product A, Product B')
      expect(supplier).to be_valid
    end

    it 'is invalid with an incorrectly formatted CNPJ' do
      supplier = Supplier.new(cnpj: '1234')
      expect(supplier).to_not be_valid
    end

    it 'is invalid with an incorrectly formatted phone number' do
      supplier = Supplier.new(phone: '123456789')
      expect(supplier).to_not be_valid
    end

    it 'is invalid with an incorrectly formatted email' do
      supplier = Supplier.new(email: 'supplier@domain')
      expect(supplier).to_not be_valid
    end

    it 'is invalid without a segment' do
      supplier = Supplier.new(segment: nil)
      expect(supplier).to_not be_valid
    end

    it 'is valid with all correct data' do
      supplier = Supplier.new(
        name: 'Supplier tester',
        cnpj: '12345678000123',
        phone: '(11) 1111-1111',
        email: 'supplier@domain.com',
        segment: 'Something',
        products: 'Product 1, Product 2'
      )
      expect(supplier).to be_valid
    end
  end
end
