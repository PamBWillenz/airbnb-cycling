require 'rails_helper'

describe LocationPolicy do
  subject { described_class }

  context "for a visitor" do 
    let(:member) { nil }
    let(:location) { FactoryGirl.create(:location) }

    permissions :new?, :edit?, :create?, :update?, :destroy? do 
      it "does not grant access for creating, editing, updating and destroying locations" do 
        expect(subject).not_to permit(member, location)
      end
    end
  end

  context "for a member creating a location" do 
    let(:location) { FactoryGirl.create(:location) }
    let(:member) { FactoryGirl.create(:member, email: "notallowedmember@yopmail.com") }

    permissions :new?, :create? do 
      it "grants access to member" do 
        expect(subject).to permit(member, location)
      end
    end

    permissions :edit?, :update?, :destroy? do 
      it "denies access to member for whom the location does not belong" do 
        expect(subject).not_to permit(member, location)
      end
    end
  end

  context "for member editing own location" do 
    let(:location) { FactoryGirl.create(:location) }

    permissions :edit?, :update?, :destroy? do 
      it "grants access if location belongs to member" do 
        expect(subject).to permit(location.member, location)
      end
    end
  end
end
