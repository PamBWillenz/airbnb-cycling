require 'rails_helper'

feature "Member reserves a location" do 
  let(:location) { FactoryGirl.create(:location_with_available_dates) }
  let(:member) { FactoryGirl.create(:member, email: "kitty@bikes.com") }

  before do 
    login_as(member, scope: :member)
    host = location.member
    FactoryGirl.create(:profile_with_pic, member: host)
  end

  scenario "by visiting location show page and selecting dates", js: true do
    visit location_path(location)
    expect(page).to have_content location.description
    expect(page).to have_content location.member.profile.bio
  
    execute_script("
      $('#datepicker-start').pickadate('picker').set(
        'select', new Date((new Date()).valueOf() + 1000*3600*24),
        { format: 'yyyy-mm-dd'});"
      )
    execute_script("
      $('#datepicker-end').pickadate('picker').set(
        'select', new Date((new Date()).valueOf() + 1000*3600*48),
        { format: 'yyyy-mm-dd'});"
      )

    click_button "Make a Reservation"
    expect(page).to have_content "Reservation Summary:"

    fill_in "card_number", with: "4242 4242 4242 4242"
    select "January"
    select "2020"
    fill_in "card_verification", with: "123"
    fill_in "address_zip", with: "10001"

    click_button "Confirm Reservation"

    expect(page).to have_content "Reservation successfully created."
    expect(page).to have_content "THANKS FOR BOOKING WITH US!"

    expect(Reservation.count).to eq 1
    reservation = Reservation.last

    expect(reservation).to have_attributes(id_for_credit_card_charge:
      a_string_starting_with("ch"), location_id: location.id, member_id: member.id, 
      start_date: Date.current + 1.day, end_date: Date.today + 2.days)

      first_available_date = AvailableDate.first 
      second_available_date = AvailableDate.second 
      expect(first_available_date.booked).to eq true
      #expect(second_available_date.booked).to eq false
  end
end
