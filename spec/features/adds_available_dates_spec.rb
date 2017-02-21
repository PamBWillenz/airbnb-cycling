require 'rails_helper'

feature "Host adds available dates to a location" do 
  let(:location) {FactoryGirl.create(:location)}

  before do 
    member = location.member
    login_as(member, scope: :member)
  end


  scenario "by adding dates to a form", js: true do 
    visit calendar_location_path(location)
    expect(page).to have_content "Available Dates"
    binding.pry
    execute_script("
      $('#datepicker-start').pickadate('picker').set(
        'select', new Date((new Date)()).valueOf() + 1000*3600*24),
        { format: 'yyyy-mm-dd' });"
      )
    execute_script("
      $('#datepicker-start').pickadate('picker').set(
        'select', new Date((new Date)()).valueOf() + 1000*3600*48),
        { format: 'yyyy-mm-dd' });"
      )
    click_button "Add available dates"
    expect(page).to have_content "Successfully added available dates"
    available_date = AvailableDate.last
    expect(page).to have_content available_date.date_available
  end
end


