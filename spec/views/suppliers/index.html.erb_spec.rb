require 'rails_helper'

RSpec.describe "suppliers/index.html.erb", type: :view do
  before do
    assign(:suppliers, [])
  end

  context "when there are no suppliers" do
    it "displays a message indicating no suppliers are registered" do
      render
      expect(rendered).to have_content("Não há Fornecedores cadastrados")
    end
  end

  context "when there are suppliers" do
    before do
      suppliers = [
        Supplier.new(id: 1, code: 'SUP001', name: 'Supplier 1', cnpj: '12345678901234', phone: '(11) 1234-5678', email: 'supplier1@example.com', segment: 'Segment 1', products: 'Product 1'),
        Supplier.new(id: 2, code: 'SUP002', name: 'Supplier 2', cnpj: '98765432109876', phone: '(11) 9876-5432', email: 'supplier2@example.com', segment: 'Segment 2', products: 'Product 2')
      ]
      assign(:suppliers, suppliers)
    end

    it "displays the suppliers in a table" do
      render
      expect(rendered).to have_selector('table')
      expect(rendered).to have_content('Código')
      expect(rendered).to have_content('Nome')
      expect(rendered).to have_content('CNPJ')
      expect(rendered).to have_content('Telefone')
      expect(rendered).to have_content('Email')
      expect(rendered).to have_content('Segmento')
      expect(rendered).to have_content('Produtos')

      expect(rendered).to have_content('SUP001')
      expect(rendered).to have_content('Supplier 1')
      expect(rendered).to have_content('12345678901234')
      expect(rendered).to have_content('(11) 1234-5678')
      expect(rendered).to have_content('supplier1@example.com')
      expect(rendered).to have_content('Segment 1')
      expect(rendered).to have_content('Product 1')

      expect(rendered).to have_content('SUP002')
      expect(rendered).to have_content('Supplier 2')
      expect(rendered).to have_content('98765432109876')
      expect(rendered).to have_content('(11) 9876-5432')
      expect(rendered).to have_content('supplier2@example.com')
      expect(rendered).to have_content('Segment 2')
      expect(rendered).to have_content('Product 2')
    end
  end

  it "displays the search form with appropriate fields" do
    render
    expect(rendered).to have_selector("form.search-form")
    expect(rendered).to have_selector("input.search-input[placeholder='Digite o código']")
    expect(rendered).to have_selector("input.search-input[placeholder='Digite o nome']")
    expect(rendered).to have_selector("input.search-input[placeholder='Digite o segmento']")
    expect(rendered).to have_selector("input.search-input[placeholder='Digite um produto']")
    expect(rendered).to have_selector("input[type='submit'][value='Filtrar']")
  end

  it "displays the clear filter button" do
    render
    expect(rendered).to have_link("Limpar Filtro", href: suppliers_path)
    expect(rendered).to have_css("a.btn.btn-primary", text: "Limpar Filtro")
  end

  context "when flash messages are present" do
    context "when flash notice is present" do
      before do
        flash[:notice] = "Supplier was successfully deleted."
        render
      end

      it "displays the success message" do
        expect(rendered).to have_selector("div.alert.alert-success", text: "Supplier was successfully deleted.")
      end
    end

    context "when flash alert is present" do
      before do
        flash[:alert] = "Supplier could not be deleted."
        render
      end

      it "displays the error message" do
        expect(rendered).to have_selector("div.alert.alert-danger", text: "Supplier could not be deleted.")
      end
    end
  end
end
