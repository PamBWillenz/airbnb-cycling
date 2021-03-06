require 'rails_helper'

feature "sign up" do
  let(:member) {FactoryGirl.create(:member)}
  
  def fill_in_signup_fields
    fill_in "member[name]", with: "cyclist01"
    fill_in "member[email]", with: "cyclist01@member.bnb"
    fill_in "member[password]", with: member.password
    click_button "Sign up"
  end

  scenario "visiting the site to sign up" do
    visit root_path
    click_link "Sign in"
    within(:css, "#sign-up") do
      click_link "Sign up"
    end
    fill_in_signup_fields
    expect(page).to have_content("You have signed up successfully.")
  end
end
