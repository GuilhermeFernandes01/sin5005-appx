require 'rails_helper'

RSpec.describe "products/edit.html.erb", type: :view do
  let(:pepperoni) { create(:ingredient, :pepperoni) }
  let(:cheese) { create(:ingredient, :cheese) }
  let(:tomato) { create(:ingredient, :tomato) }

  let(:pizza_pepperoni) do
    create(:product, :pizza_pepperoni)
  end

  let(:errors) do
    instance_double(ActiveModel::Errors)
  end

  before do
    allow(pizza_pepperoni).to receive(:errors).and_return(errors)

    assign(:product, pizza_pepperoni)
    assign(:ingredients, [ pepperoni, cheese, tomato ])
  end

  describe "when I am on the new product page" do
    context "with no errors" do
      before do
        allow(errors).to receive(:any?).and_return(false)
      end

      it "displays the correct heading" do
        render

        expect(rendered).to have_selector('h1#page-heading', text: 'Editar Produto')
      end

      it "displays the new product form" do
        render

        expect(rendered).to have_selector("form#product-form")

        expect(rendered).to have_selector("form#product-form") do |form|
          expect(form).to have_field("Nome do produto")
          expect(form).to have_field("Preço")
          expect(form).to have_field("Categoria")

          expect(form).to have_button("Salvar")
        end
      end

      it "should show the ingredients" do
        render

        expect(rendered).to have_selector("label", text: "Pepperoni")
        expect(rendered).to have_selector("label", text: "Queijo")
        expect(rendered).to have_selector("label", text: "Tomate")
      end
    end

    context "with errors after trying to save" do
      before do
        allow(errors).to receive(:any?).and_return(true)
        allow(errors).to receive(:full_messages).and_return([ "Name can't be empty", "Price can't be empty", "Category can't be empty" ])
      end

      it "shows the product errors" do
        render

        expect(rendered).to have_selector("li")

        expect(rendered).to have_selector("li", text: "Name can't be empty")
        expect(rendered).to have_selector("li", text: "Price can't be empty")
        expect(rendered).to have_selector("li", text: "Category can't be empty")
      end
    end
  end
end
