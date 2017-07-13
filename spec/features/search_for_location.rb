require 'rails_helper'

feature "Member searches for locations" do 

  before do 
    member = FactoryGirl.create(:member)
    member.create_profile
    FactoryGirl.create_list(:location_with_available_dates, 15, title: "Location with Date A", member: member)
    FactoryGirl.create_list(:location_with_available_dates, 15, title: "Location with Date B", member: member)
    @first_location = Location.first
    @last_location = Location.last
  end

  scenario "by visiting index page with no search and clicks to view more" do 
    visit locations_path
    expect(page).to have_content @first_location.title
    expect(page).not_to have_content @last_location.title
    click_link "Next"
    expect(page).to have_content @last_location.title
    expect(page).not_to have_content @first_location.title
  end

  scenario "by filling out search form and clicks to view more" do 
    visit root_path
    expect (page).to have_button "Find Properties"

    fill_in "address", with: "Sun Valley, Idaho"
    fill_in "start_date", with: Date.tomorrow
    fill_in "end_date", with: Date.today + 2.days
    click_button "Find Properties"

    expect(page).to have_content @last_location.title
    expect(page).not_to have_content @first_location.title
  end

  scenario "by place and dates range" do 
    member = FactoryGirl.create(:member)
    member.create_profile
    location_va = FactoryGirl.create(:location, title: "Virginia Location with Date A", member: member)
    FactoryGirl.create(:available_date, location: location_va, date: Date.today + 3.days)
    FactoryGirl.create(:available_date, location: location_va, date: Date.today + 5.days)

    location_sun_valley = FactoryGirl.create(:location, title: "Sun Valley Location with Date A", member: member)
    FactoryGirl.create(:available_date, location: location_sun_valley, date: Date.today + 3.days)
    FactoryGirl.create(:available_date, location: location_sun_valley, date: Date.today + 5.days)

    visit root_path
    expect(page).to have_button "Find Properties"

    fill_in "address", with: "Sun Valley, Idaho"
    fill_in "start_date", with: Date.today + 3.days
    fill_in "end_date", with: Date.today + 5.days
    click_button "Find Properties"

    expect(page).to have_content("Virginia Location Date A")
    expect(page).to have_content("Sun Valley Location Date A")
    expect(page.all(h2).count.to eq 2)
  end
end

