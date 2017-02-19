require 'rails_helper'

let(:location) { FactoryGirl.create(:location_with_available_dates) }

first_available_date = AvailableDate.first 
second_available_date = AvailableDate.second 
expect(first_available_date.reserved).to eq true
expect(second_available_date.reserved).to eq false
