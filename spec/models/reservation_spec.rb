require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe "validations" do 
    it "has a valid factory" do
      expect(FactoryGirl.create(:reservation)).to be_valid
    end
  end

  describe "associations" do 
    it { should belong_to(:location) }
    it { should belong_to(:member) }
  end

  describe "#update_after_refund" do
    it "saves id for refund and makes dates available again" do
      location = FactoryGirl.create(:location_with_available_dates)
      reservation = Reservation.create(
        start_date: Date.tomorrow,
        end_date: Date.today + 2.days,
        location_id: location.id
      )
     reservation_array = (reservation.start_date..reservation.end_date - 1.day).to_a
     AvailableDate.where(location_id: location.id).where(available_date: reservation_array).update_all(booked: true)
     id_for_refund = "re_123123123123"
     
     reservation.update_after_refund(id_for_refund)
     reservation.reload
     expect(reservation.id_for_refund).to eq id_for_refund

     #available_dates = AvailableDate.where(location_id: location.id).where(available_date: reservation_array)
     first_available_date = available_dates.first
     expect(first_available_date.booked).to eq false
    end
  end
end
