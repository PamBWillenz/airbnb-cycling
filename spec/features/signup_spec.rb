require 'rails_helper'

feature "sign up" do
  let(:member) {FactoryGirl.create(:member)}
  
  def fill_in_signup_fields
    fill_in "member[email]", with: "cyclist01@member.bnb"
    fill_in "member[password]", with: "cyclist01"
    click_button "Sign up"
  end

  scenario "visiting the site to sign up" do
    visit root_path
    click_link "Sign up"
    fill_in_signup_fields
    expect(page).to have_content("You have signed up successfully.")
  end
end