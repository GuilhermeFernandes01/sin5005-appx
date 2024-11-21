require 'rails_helper'

RSpec.describe "suppliers/edit.html.erb", type: :view do
  let(:supplier) { create(:supplier, name: 'Test Supplier', phone: '(11) 1234-5678', email: 'supplier@test.com', segment: 'Food', products: 'Product A') }

  before do
    assign(:supplier, supplier)
    render
  end

  it "displays the title 'Editar Informações'" do
    expect(rendered).to have_selector('h1', text: 'Editar Informações')
  end

  it "displays the supplier's current information in the form" do
    expect(rendered).to have_field('Nome', with: 'Test Supplier')
    expect(rendered).to have_field('Telefone', with: '(11) 1234-5678')
    expect(rendered).to have_field('Email', with: 'supplier@test.com')
    expect(rendered).to have_field('Segmento', with: 'Food')
    expect(rendered).to have_field('Produtos', with: 'Product A')
  end

  context "with flash notice" do
    before do
      flash[:notice] = "Informações atualizadas com sucesso."
      render
    end

    it "displays the success message" do
      expect(rendered).to have_selector('.alert.alert-success', text: 'Informações atualizadas com sucesso.')
    end
  end

  context "with flash alert" do
    before do
      flash.now[:alert] = "Erro ao atualizar informações."
      render
    end

    it "displays the error message" do
      expect(rendered).to have_selector('.alert.alert-danger', text: 'Erro ao atualizar informações.')
    end
  end

  it "has a submit button with the text 'Salvar'" do
    expect(rendered).to have_button('Salvar')
  end

  it "has a link to return to the supplier list" do
    expect(rendered).to have_link('Retornar para a lista de fornecedores', href: suppliers_path)
  end
end
