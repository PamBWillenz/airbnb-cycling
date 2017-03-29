require 'rails_helper'

feature "Member views location" do

  let(:location) { FactoryGirl.create(:location_with_available_dates) }
  let(:member) { FactoryGirl.create(:member, email: "othermember@yoplait.com") }

  before do 
    login_as(member, scope: :member)
  end

  scenario "by visiting location page", js: true do
    visit location_path(location)
    expect(page).to have_css("div#map-container")
    expect(page).to have_css("td.fc-bgevent", count: 4)
  end
end
