require 'rails_helper'

feature "Guest cancels reservation" do
  let(:location) { FactoryGirl.create(:location_with_available_dates) }
  let(:member) { FactoryGirl.create(:member)}

  before do 
    login_as(member, scope: :member)
  end

  scenario "by visiting index of upcoming reservations and clicking cancel", js: true do 
    create_reservation
    visit reservations_path
    page.accept_confirm do 
      click_link "Cancel Reservation"
    end
    expect(page).to have_content "Your reservation was successfully cancelled."
    reservation = Reservation.last
    expect(reservation).to have_attributes(id_for_refund: a_string_starting_with("re"))
  end

  def create_reservation
    visit new_reservation_path(
      reservation: {
        start_date: Date.tomorrow, end_date: Date.tomorrow + 2.days,
        location_id: location.id, member_id: member.id
        }
      )
    fill_in "card_number", with: "4242 4242 4242 4242"
    select "January"
    select "2020"
    fill_in "card_verification", with: "123"
    fill_in "address_zip", with: "10001"
    click_button "Book Now"
    sleep 5
    expect(Reservation.count).to eq 1
  end
end
