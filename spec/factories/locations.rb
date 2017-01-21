FactoryGirl.define do
  factory :location do
    title "MyString"
    description "MyText"
    address_1 "MyString"
    address_2 "MyString"
    city "MyString"
    state "MyString"
    postcode "MyString"
    bike_type "MyString"
    guests 1
    member nil
  end
end
