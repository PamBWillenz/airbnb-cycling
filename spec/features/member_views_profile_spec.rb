require 'rails_helper'

feature "member views profile" do 
  let(:profile) {FactoryGirl.create(:profile_with_pic)}

  before do
    login_as(profile.member, :scope => :member)
  end

  scenario "visiting index page of profiles" do 
    visit profiles_path

    expect(page).to have_content "Traveling Cyclist Profiles"
    expect(page).to have_content(:profile)

    expect(page).to have_link("View Profile", href: member_profile_path(profile.member, profile))
  end

  scenario "visiting profile show page" do 
    visit profiles_path

    find("a[href='#{member_profile_path(profile.member, profile)}']", :match => :first).click 

    expect(page).to have_content "#{profile.member.name}'s Profile"
    expect(page).to have_content profile.bio
    expect(page).to have_css("img[src*='profile_pic']")

  end

end