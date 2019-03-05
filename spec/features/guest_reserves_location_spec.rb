# require 'rails_helper'

# feature "guest reserves a location with a credit card" do 

#   scenario "guest reserves location", js: true do 
#     within_frame 0 do
#       fill_in "cardmember", with: "4242 4242 4242 4242"
#       fill_in "exp-date", with: "12/20"
#       fill_in "cvc", with: "123"
#       fill_in "postal", with: "10001"
#     end
#     expect(Reservation.last).to have_attributes(id_for_credit_card_charge: a_string_starting_with("ch"))
#   end
# end
