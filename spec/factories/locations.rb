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

      factory :location_with_available_dates do
          after(:create) {|instance| create(:available_date, location: instance) }
          after(:create) {|instance| create(:available_date, location: instance, available_date: Date.today + 2.days) }
          after(:create) {|instance| create(:available_date, location: instance, available_date: Date.today + 3.days) }
          after(:create) {|instance| create(:available_date, location: instance, available_date: Date.today + 4.days) }
    end
  end
end
