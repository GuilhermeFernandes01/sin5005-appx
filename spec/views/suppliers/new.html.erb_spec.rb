require 'rails_helper'

RSpec.describe "suppliers/new.html.erb", type: :view do
  before do
    assign(:supplier, Supplier.new)
  end

  it "renders the new supplier form" do
    render
    expect(rendered).to have_selector("form[action='#{suppliers_path}'][method='post']")
    expect(rendered).to have_field("supplier[name]")
    expect(rendered).to have_field("supplier[cnpj]")
    expect(rendered).to have_field("supplier[phone]")
    expect(rendered).to have_field("supplier[email]")
    expect(rendered).to have_field("supplier[segment]")
    expect(rendered).to have_field("supplier[products]")
  end

  it "displays a success flash message" do
    flash[:notice] = "Fornecedor foi criado com sucesso."
    render
    expect(rendered).to have_css('.alert-success', text: 'Fornecedor foi criado com sucesso.')
  end

  it "displays an alert flash message" do
    flash.now[:alert] = "There was an error."
    render
    expect(rendered).to have_css('.alert-danger', text: 'There was an error.')
  end

  it "has a link to return to the suppliers index" do
    render
    expect(rendered).to have_link('Retornar para a lista de fornecedores', href: suppliers_path)
  end
end
