require 'rails_helper'

feature "profiles" do
  let(:member) {FactoryGirl.create(:member)}

  def fill_in_fields
    fill_in "member[name]", with: "Jane Doe"
    fill_in "profile", with: FFaker::Lorem.paragraph(2)
  end
   
  scenario "member creates profile" do
    visit new_member_profile_path(member)
    fill_in "profile", with: FFaker::Lorem.paragraph(2)
    click_button "Create Profile"
    expect(page).to have_content("Profile was successfully created.")
  end
end