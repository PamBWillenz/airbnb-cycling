class Reservation < ApplicationRecord
  belongs_to :member
  belongs_to :location

  validate :dates_are_available

  scope :upcoming, -> { where("start_date >= ?", Date.today) }
  scope :upcoming_for_member, ->(member) {
    upcoming.where(member_id: member.id) if member.present?
  }


  def dates_are_available
    start_date_overlap = location.reservations.where(start_date: start_date..end_date - 1.day)
    end_date_overlap = location.reservations.where(end_date: start_date..end_date - 1.day)
    
    if start_date_overlap.exists? || end_date_overlap.exists?
      errors[:base] << "Some of the dates of your reservation are not available. Please try different dates."
    end
  end

  def dates_booked
    (self.start_date..self.end_date).each do |date|
      AvailableDate.where(location_id: location.id).where(available_date: date).update(booked: true)
    end
  end
end

