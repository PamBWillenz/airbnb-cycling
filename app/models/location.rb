class Location < ApplicationRecord
  belongs_to :member
  has_many :reservations, dependent: :destroy
  has_many :available_dates, dependent: :destroy
  has_many :location_images, dependent: :destroy
  accepts_nested_attributes_for :location_images, allow_destroy: true

  validates_presence_of :title,
                        :description,
                        :address_1,
                        :city,
                        :state,
                        :bike_type,
                        :guests,
                        :member_id

  geocoded_by :full_street_address
  after_validation :geocode, if: ->(obj){ obj.address_1.present? and obj.address_changed? }

  def full_street_address
    [address_1, city, state].compact.join(", ")
  end

  def address_changed?
    address_1_changed? || city_changed? || state_changed? 
  end

  def create_available_dates(start_date, end_date)
    dates = start_date.to_date.upto(end_date.to_date)
    dates.each do |date|
      AvailableDate.find_or_create_by(available_date: date, location_id: self.id, booked: false)
    end
  end

  def future_available_dates
    future_dates = AvailableDate.where("available_date >= ?", Date.today)
    future_dates.where(booked: false)
  end
end
