require "rails_helper"

feature "signing in" do
      let(:member) {FactoryGirl.create(:member)}
      
      feature "Member creates a location" do 
      
      scenario "by entering a description and uploading images" do
        login_as(member, :scope => :member)
        visit new_location_path
        expect(page).to have_content("Your New Location")
        fill_in "location[title]", with: "Location title"
        fill_in "location[description]", with: FFaker::Lorem.paragraph(2)
        fill_in "location[address_1]", with: "2 Ski Drive"
        fill_in "location[address_2]", with: "Suite 100"
        fill_in "location[city]", with: "Sun Valley"
        fill_in "location[state]", with: "Idaho"
        fill_in "location[postcode]", with: "90765"
        fill_in "location[bike_type]", with: "Mountain"
        fill_in "location[guests]", with: 1

        click_button "Create Location"

        expect(page).to have_content("Location was successfully created.")
        expect(page).to have_content "Add Pictures"
        expect(Location.count).to eq 1
       

        picture_1_path = 'spec/fixtures/files/picture_1.jpg'

        attach_file "location[location_images_attributes][0][picture]", picture_1_path
        click_button "UPDATE & SAVE"

        expect(LocationImage.count).to eq 1
        expect(LocationImage.first.picture_order).to eq 1
      end

      scenario "opens the location form when a member is not signed in" do 
        visit new_location_path
        expect(page).to have_content("You need to sign in or sign up before continuing.")
      end
      scenario "goes to location form when member is not logged in" do 
        visit new_location_path
        expect(page).to have_content("You need to sign in or sign up before continuing.")
      end
    end
end

