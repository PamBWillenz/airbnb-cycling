require 'rails_helper'

feature "profiles" do
  let(:member) {FactoryGirl.create(:member)}

  def fill_in_fields
    fill_in "member[name]", with: "Jane Doe"
    fill_in "profile[bio]", with: FFaker::Lorem.paragraph(2)
  end
   
  scenario "member creates profile" do
    login_as(member, :scope => :member)
    visit new_member_profile_path(member)
    expect(page).to have_content "Profiles"
    fill_in "profile[bio]", with: FFaker::Lorem.paragraph(2)
    profile_pic_path = 'spec/fixtures/files/profile_pic.jpg'
    attach_file "profile[profile_pic]", profile_pic_path
    click_button "Create Profile"
    expect(profile).to have_attributes(profile_pic_file_name: a_value)
    profile = Profile.last
    expect(page).to have_content("You successfully created your profile.")
  end
end