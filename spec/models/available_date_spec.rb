require 'rails_helper'

RSpec.describe AvailableDate, type: :model do
  describe "validations" do 
    it "has a valid factory" do 
      location = FactoryGirl.create(:location)
      expect(FactoryGirl.create(:available_date, location: location)).to be_valid
    end

    it { should validate_presence_of(:available_date)}
  end

  describe "assocations" do 
    it { should belong_to(:location) }
  end

  describe ".upcoming" do
    it "returns only future available_dates" do
      location = FactoryGirl.create(:location_with_available_dates)
      upcoming_available_date = location.available_dates.first
      past_available_date = FactoryGirl.build(:available_date, available_date: Date.yesterday, location: location)
      past_available_date.save(validate: false)

      expect(AvailableDate.upcoming).to include(upcoming_available_date)
      expect(AvailableDate.upcoming).not_to include(past_available_date)  
    end
  end

  describe ".unreserved" do 
    it "returns only unreserved available_dates" do 
      location = FactoryGirl.create(:location_with_available_dates)
      unreserved_available_date = location.available_dates.first
      booked_location = FactoryGirl.build(:available_date, booked: true, location: location)
      booked_location.save(validate: false)

      expect(AvailableDate.unreserved).to include(unreserved_available_date)
      expect(AvailableDate.unreserved).not_to include(booked_location)
    end
  end

  

  describe ".available_for_reservation" do 
    it "returns available dates for reservations" do 
      location = FactoryGirl.create(:location_with_available_dates)
      available_for_reservation = AvailableDate.create(location: location, available_date: Date.tomorrow, booked: false)
      date_range_array = Date.tomorrow..Date.today + 2.days 
      not_available_for_reservation = AvailableDate.create(location: location, available_date: Date.tomorrow, booked: true)
      

      expect(AvailableDate.available_for_reservation(date_range_array)).to include(available_for_reservation)
      expect(AvailableDate.available_for_reservation(date_range_array)).not_to include(not_available_for_reservation)
      
    end
  end
end
