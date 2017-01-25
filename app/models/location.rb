class Location < ApplicationRecord
  belongs_to :member

  has_many :location_images, dependent: :destroy
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

  # def main_image
  #   LocationImages.where(location_id: id).where(picture_order: 1)
  # end
end
