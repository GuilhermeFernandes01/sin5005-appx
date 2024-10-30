require 'rails_helper'

RSpec.describe "home/index.html.erb", type: :view do
  it 'exibe o título corretamente' do
    render
    expect(rendered).to have_content("Bem-vindo à Pizzaria EACH")
  end
end
