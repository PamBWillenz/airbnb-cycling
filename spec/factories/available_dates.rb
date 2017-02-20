FactoryGirl.define do
  factory :available_date do
    date_available Date.tomorrow
    location
    booked false
  end
end
