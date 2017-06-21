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
end
