class LocationImage < ApplicationRecord
  belongs_to :location

  has_attached_file :picture, styles: {
    small: "150x150#", 
    medium: "200x200>", 
    large: "300x300>"
  }, default_url: "/images/:style/missing.png"

    validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/

    after_create :set_picture_order

    def set_picture_order
      if location.location_images.count == 1
        update_attribute(:picture_order, 1)
      else
        next_picture_order = location.location_images.count + 1
        update_attribute(:picture_order, next_picture_order)
      end
    end
end
