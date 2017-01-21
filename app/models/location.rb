class Location < ApplicationRecord
  belongs_to :member, dependent: :destroy

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
