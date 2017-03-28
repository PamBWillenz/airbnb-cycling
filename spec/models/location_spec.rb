require 'rails_helper'

RSpec.describe Location, type: :model do
  
  describe "validations" do 
    it "has a valid factory" do 
      expect(FactoryGirl.create(:location)).to be_valid
    end

    it { should validate_presence_of(:member_id) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:address_1) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:bike_type) }
    it { should validate_presence_of(:guests) }

    it do 
      should accept_nested_attributes_for(:location_images)
      .allow_destroy(true)
    end
  end

  describe "associations" do 
    it { should belong_to(:member) }
    it { should have_many(:location_images).dependent(:destroy) }
    it { should have_many(:available_dates) }
  end

  describe "#create_available_dates" do 
    it "creates available dates for a date range for that location" do 
      location = FactoryGirl.create(:location)
      start_date = (Date.tomorrow).to_s
      end_date = (Date.today + 2.days).to_s

      location.create_available_dates(start_date, end_date)

      expect(AvailableDate.count).to eq 2
      available_date = AvailableDate.last
      expect(available_date.location_id).to eq location.id 
      expect(available_date.available_date).to eq Date.today + 2.days
      expect(available_date.booked).to eq false
    end

    describe "#future_available_dates" do 
      it "gathers all the future available dates" do 
        location = FactoryGirl.create(:location_with_available_dates)

        results = location.future_available_dates
        last_location = Location.last

        expect(results.count).to eq 4
        expect(results).to include(last_location)
      end
    end
  end
end
