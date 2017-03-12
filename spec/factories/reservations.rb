FactoryGirl.define do
  factory :reservation do
    start_date "2017-08-15"
    end_date "2017-08-15"
    location
    association :member, email: "kitty@goeswild.com"
  end
end
