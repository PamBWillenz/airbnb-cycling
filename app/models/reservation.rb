class Reservation < ApplicationRecord
  belongs_to :member
  belongs_to :location

  validate :dates_are_available

  def dates_are_available
    if reservation_overlap? || dates_booked
      errors[:base] << "Some of the dates of your reservation are not available. Please try different dates."
    end
  end

  def reservation_overlap?
    start_date_overlap = location.reservations.where(start_date: start_date..end_date - 1.day)
    end_date_overlap = location.reservations.where(end_date: start_date..end_date - 1.day)
    start_date_overlap.exists? || end_date_overlap.exists?
  end

  def dates_booked
    (self.start_date..self.end_date).each do |date|
      AvailableDate.where(available_date: date).update(booked: true)
    end
  end
end

