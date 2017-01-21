require 'rails_helper'

RSpec.describe "home/index.html.erb", type: :view do
  it 'displays the site name' do
    render
    expect(rendered).to have_text ("Book your perfect bike vacation")
  end
end
