require 'rails_helper'

feature "Host authorizes Stripe Connect" do 
  let(:member) { FactoryGirl.create(:member) }


  before do 
    login_as(member, scope: :member)
  end

  scenario "by clicking on link to Stripe" do 
    visit root_path
    click_link "Become a host"
    expect(page).to have_content "Get Paid with Stripe!"
    click_link "Connect With Stripe"
    expect(page).to have_content "Congrats on connecting your Stripe account!"
    member.reload
    expect(member.stripe_user_id).not_to eq nil
    expect(page).to have_content("New Location")
  end
end
