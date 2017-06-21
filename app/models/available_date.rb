class AvailableDate < ApplicationRecord
  belongs_to :location

  validates_presence_of :available_date

  scope :upcoming, -> { where("available_date >= ?", Date.today) }
  scope :unreserved, -> { where(booked: false) }
  scope :available_for_reservation, -> (date_range_array) {
    upcoming.unreserved.where(available_date: date_range_array) if date_range_array.present?
  }
end
