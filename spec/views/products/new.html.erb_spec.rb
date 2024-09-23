require 'rails_helper'

RSpec.describe "products/new.html.erb", type: :view do
  before do
    assign(:product, Product.new)
  end

  it "displays the correct heading" do
    render

    expect(rendered).to have_selector('h1#page-heading', text: 'Novo Produto')
  end

  it "displays the new product form" do
    render

    expect(rendered).to have_selector("form#product-form")

    expect(rendered).to have_selector("form#product-form") do |form|
      expect(form).to have_field("Nome do produto")
      expect(form).to have_field("Preço")
      expect(form).to have_field("Categoria")
      expect(form).to have_field("Requer ingredientes")

      expect(form).to have_button("Criar")
    end
  end
end
