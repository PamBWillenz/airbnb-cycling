require 'rails_helper'

feature "Member reserves a location" do 
  let(:location) {FactoryGirl.create(:location)}

  scenario "by visiting location show page and selecting dates" do
    visit location_path(location)
    expect(page).to have_content location.title

    fill_in "reservation[start_date]", with: Date.tomorrow
    fill_in "reservation[end_date]", with: Date.today + 2.days

    click_button "Reserve Location"

    expect(page).to have_content "Reservation successfully created."

    expect(Reservation.count).to eq 1
    reservation = Reservation.last
    expect(reservation.location_id).to eq location.id 
    expect(reservation.start_date).to eq Date.tomorrow
    expect(reservation.end_date).to eq Date.today + 2.days
  end
end