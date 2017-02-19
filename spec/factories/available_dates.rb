FactoryGirl.define do
  factory :available_date do
    date_available Date.tomorrow
    location_id 1
    booked false
  end
end
