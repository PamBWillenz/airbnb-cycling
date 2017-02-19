require 'rails_helper'

RSpec.describe AvailableDate, type: :model do
  describe "validations" do 
    it "has a valid factory" do 
      location = FactoryGirl.create(:location)
      expect(FactoryGirl.create(:available_date, location: location)).to be_valid
    end

    it { should validate_presence_of(:date_available)}
  end

  describe "assocations" do 
    it { should belong_to(:location) }
  end
end
