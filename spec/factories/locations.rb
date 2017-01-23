FactoryGirl.define do

    sequence :title do |n|
        "My title" + n.to_s
    end
    
  factory :location do
    title 
    description "MyText"
    address_1 "2 Ski Drive"
    address_2 "My address"
    city "Sun Valley"
    state "Idaho"
    postcode "My Postcode"
    bike_type "Mountain"
    guests 1
    association :member, factory: :member
  end
end
