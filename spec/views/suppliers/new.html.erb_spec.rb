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
end
