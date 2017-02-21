class AvailableDate < ApplicationRecord
  belongs_to :location

  validates_presence_of :available_date
end
