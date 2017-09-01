require 'rails_helper'

feature "Host views calendar", js: true do
  let(:location) {FactoryGirl.create(:location_with_available_dates)}
  let(:guest) { FactoryGirl.create(:member, email: "kitty@rocks.com") }


  before do
    host = location.member
    login_as(host, scope: :member)
    @upcoming_reservation = Reservation.create(
      location_id: location.id,
      member_id: guest.id,
      start_date: Date.tomorrow,
      end_date: Date.current + 2.days
    )
    reservation_array = (@upcoming_reservation.start_date..@upcoming_reservation.end_date - 1.day).to_a
    AvailableDate.where(location_id: location.id).where(available_date: reservation_array).update_all(booked: true)
  end


  scenario "and sees available dates and a reservation", js: true do
    visit calendar_location_path(location)
    expect(page).to have_css("td.fc-bgevent", count: 3)
    expect(page).to have_content @upcoming_reservation.id
    expect(page).to have_css("td.fc-event-container", count: 2)
  end
end
