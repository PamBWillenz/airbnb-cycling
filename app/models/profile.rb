class Profile < ActiveRecord::Base
  validates_presence_of :bio
  validates_presence_of :member_id
  
  belongs_to :member
end
