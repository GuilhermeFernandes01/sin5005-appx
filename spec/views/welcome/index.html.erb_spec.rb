require 'rails_helper'

RSpec.describe "welcome/index.html.erb", type: :view do
  it "displays the welcome message" do
    render

    expect(rendered).to have_selector('h1', text: 'Welcome#index')
    expect(rendered).to have_selector('p', text: 'Find me in app/views/welcome/index.html.erb')
  end
end
