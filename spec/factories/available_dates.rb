FactoryGirl.define do
  factory :available_date do
    available_date Date.tomorrow
    location
    booked false
  end
end
