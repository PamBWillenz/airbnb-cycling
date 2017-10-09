require 'rails_helper'

feature "Member views location", js: true do

  let(:location) { FactoryGirl.create(:location_with_available_dates) }
  let(:member) { FactoryGirl.create(:member, email: "othermember@yoplait.com") }

  before do 
    login_as(member, scope: :member)
    host = location.member
    FactoryGirl.create(:profile_with_pic, member: host)
  end

  scenario "by visiting location page", js: true do
    visit location_path(location)
    expect(page).to have_content location.price
    expect(page).to have_css("div#map-container")
    #page.has_css?("td.fc-bgevent", count: 4)
  end
end
