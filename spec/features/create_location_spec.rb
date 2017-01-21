require "rails_helper"

feature "Member creates a location" do 
  let(:member) { FactoryGirl.create(:member) }

  before do 
    login_as(member, :scope => :member)
    visit new_location_path
    fill_in "location[title]", with: "Location title"
    fill_in "location[description]", with: "Location description"
    fill_in "location[address_1]", with: "2 Ski Drive"
    fill_in "location[address_2]", with: ""
    fill_in "location[city]", with: "Sun Valley"
    fill_in "location[state]", with: "Idaho"
    fill_in "location[postcode]", with: "Postcode"
    fill_in "location[bike_type]", with: "Mountain"
    fill_in "location[guests]", with: 1
    click_button "Submit"
  end

  scenario "fill in the form of a new location when a member is logged in" do 
    expect(page).to have_content("Location was successfully created.")

    visit locations_path
    expect(page).to have_content("Location title")
    expect(page).to have_content("Location Description")
    expect(page).to have_content("Mountain")
    expect(page).to have_content("1")
  end
end

