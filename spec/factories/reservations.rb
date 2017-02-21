FactoryGirl.define do
  factory :reservation do
    start_date "2017-02-04"
    end_date "2017-02-06"
    location
    member
    association :member, email: "kitty@goeswild.com"
  end
end
