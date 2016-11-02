require 'rails_helper'

feature "member views profile" do 
  let(:member) {FactoryGirl.create(:member)}

  before do
    login_as(member, :scope => :member)
  end

  scenario "visiting index page of profiles" do 
    visit profiles_path

    expect(page).to have_content "Traveling Cyclist Profiles"
    expect(page).to have_content(:profile)

    expect(page).to have_link("View Profile", href: member_profile_path)
  end

  scenario "visiting profile show page" do 
    visit profiles_path

    find("a[href='#{member_profile_path}']").click

    expect(page).to have_content "#{member.name}'s Profile"
    expect(page).to have_content profile.bio
    expect(page).to have_content "profile[profile_pic]", profile_pic_path
  end

end