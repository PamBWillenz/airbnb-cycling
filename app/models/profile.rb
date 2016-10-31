class Profile < ApplicationRecord
  validates_presence_of :bio
  validates_presence_of :member_id

  belongs_to :member

  has_attached_file :profile_pic, styles: {
    small: "150x150#", 
    medium: "200x200>", 
    large: "300x300>"
  }, default_url: "/images/:style/missing.png"
  
  validates_attachment_content_type :profile_pic, content_type: /\Aimage\/.*\Z/
end
