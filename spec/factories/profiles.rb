FactoryGirl.define do
  factory :profile do
    bio "MyText"
    member_id 1
    name "MyString"
    profile_pic { File.new("#{Rails.root}/spec/fixtures/files/profile_pic.jpg") }
  end
end
