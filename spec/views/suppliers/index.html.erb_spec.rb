require 'rails_helper'

RSpec.describe "suppliers/index.html.erb", type: :view do
  before do
    assign(:suppliers, [])
  end

  context "when there are no suppliers" do
    it "displays a message indicating no suppliers are registered" do
      render
      expect(rendered).to have_content("Não há fornecedores cadastrados")
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
    expect(rendered).to have_selector("form")
    expect(rendered).to have_selector("input.search-form-param[placeholder='Digite o código']")
    expect(rendered).to have_selector("input.search-form-param[placeholder='Digite o nome']")
    expect(rendered).to have_selector("input.search-form-param[placeholder='Digite o segmento']")
    expect(rendered).to have_selector("input.search-form-param[placeholder='Digite um produto']")
    expect(rendered).to have_selector("input[type='submit'][value='Filtrar']")
  end

  it "displays the clear filter button" do
    render
    expect(rendered).to have_link("Limpar filtro", href: suppliers_path)
    expect(rendered).to have_css("a.clean-link", text: "Limpar filtro")
  end

  context "when flash messages are present" do
    context "when flash notice is present" do
      before do
        flash[:notice] = "Fornecedor foi excluído com sucesso."
        render
      end

      it "displays the success message" do
        expect(rendered).to have_selector("div.alert.alert-success", text: "Fornecedor foi excluído com sucesso.")
      end
    end

    context "when the user cancels the deletion" do
      before do
        flash[:notice] = nil
        render
      end

      it "does not set a flash message" do
        expect(rendered).not_to have_selector("div.alert.alert-success")
      end
    end
  end
end
