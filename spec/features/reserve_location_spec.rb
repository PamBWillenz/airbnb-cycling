require 'rails_helper'

feature "Member reserves a location" do 
  let(:location) { FactoryGirl.create(:location_with_available_dates) }
  let(:member) { FactoryGirl.create(:member, email: "kitty@bikes.com") }

  before do 
    login_as(member, scope: :member)
    host = location.member
    FactoryGirl.create(:profile_with_pic, member: host)
  end

  context "with valid data" do
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

      click_button "Book Now"

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

  context "with invalid data" do 
    scenario "charge is declined", js: true do 
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

      fill_in "card_number", with: "4000 4000 4000 4002"
      select "January"
      select "2020"
      fill_in "card_verification", with: "123"
      fill_in "address_zip", with: "10001"

      click_button "Book Now"
      sleep 5
      expect(page).to have_content "Your card was declined."
    end

    scenario "stripe returns error for invalid cvc-code", js: true do 
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
      fill_in "card_verification", with: "88"
      fill_in "address_zip", with: "10001"

      click_button "Book Now"
      sleep 5

      expect(page).to have_content "Your card's security code is invalid."
    end

    scenario "card has expired", js: true do 
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

      fill_in "card_number", with: "4000 4000 4000 0069"
      select "January"
      select "2020"
      fill_in "card_verification", with: "123"
      fill_in "address_zip", with: "10001"

      click_button "Book Now"
      sleep 5

      expect(page).to have_content "Your card has expired."
    end
      

    scenario "processing error", js: true do 
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

      fill_in "card_number", with: "4000 0000 0000 0119"
      select "January"
      select "2020"
      fill_in "card_verification", with: "123"
      fill_in "address_zip", with: "10001"

      click_button "Book Now"

      expect(page).to have_content "An error occurred while processing your card."
    end
  end
end
      
