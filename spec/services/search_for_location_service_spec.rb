require 'rails_helper'

RSpec.describe SearchForLocationService, type: :service do 

  describe "search for locations" do 
    it "return locations when dates range and address are defined", :vcr do 
      location = FactoryGirl.create(:location)
      location.create_available_dates(Date.today, Date.today + 10.days)

      locations = SearchForLocationService.new({
        start_date: Date.tomorrow.to_s,
        end_date: (Date.today + 3.days).to_s,
        address: "Sun Valley, Idaho"
        }).matches

      expect(locations.count(:all)).to eq 1
    end
  end
end
