require 'rails_helper'

RSpec.describe LocationImage, type: :model do
  describe "validations" do 
    it "has a valid factory" do 
      expect(FactoryGirl.create(:location_image)).to be_valid
    end

    describe "associations" do 
      it { should belong_to(:location) }
    end
  end
end
