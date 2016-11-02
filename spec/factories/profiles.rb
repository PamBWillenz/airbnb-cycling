FactoryGirl.define do 
  factory :profile do 
    bio FFaker::Lorem.paragraph
    name FFaker::Name.name

    member

    factory :profile_with_pic do 
      profile_pic { File.new("#{Rails.root}/spec/fixtures/files/profile_pic.jpg") }
    end
  end
end
