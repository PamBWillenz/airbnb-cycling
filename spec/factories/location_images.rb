FactoryGirl.define do
  factory :location_image do
    caption "MyString"
    picture_order 1
    picture { File.new("#{Rails.root}/spec/fixtures/files/picture_1.jpg") }
    location
  end
end
