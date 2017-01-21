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
    it { should validate_presence_of(:address_2) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:postcode) }
    it { should validate_presence_of(:bike_type) }
    it { should validate_presence_of(:guests) }
  end

  describe "associations" do 
    it { should belong_to(:member) }
    it { should belong_to(:member).dependent(:destroy) }
  end
end
