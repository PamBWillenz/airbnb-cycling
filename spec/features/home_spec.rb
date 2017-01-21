require 'rails_helper'


feature "visiting the homepage" do
  scenario "the visitor sees welcome text" do
    visit root_path
    expect(page).to have_text("Book your perfect bike vacation")
  end
end
