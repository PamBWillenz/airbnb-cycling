class Location < ApplicationRecord
  belongs_to :member, dependent: :destroy

  has_many :location_images
  accepts_nested_attributes_for :location_images, allow_destroy: true

  validates_presence_of :title,
                        :description,
                        :address_1,
                        :address_2,
                        :city,
                        :state,
                        :postcode,
                        :bike_type,
                        :guests,
                        :member_id
end
