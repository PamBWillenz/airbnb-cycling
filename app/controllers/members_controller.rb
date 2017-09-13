class MembersController < ApplicationController
  before_action :authenticate_member!

  def payout_account
    if current_member.stripe_user_id.present?
      redirect_to host_locations_path, alert:
        "You have already connected your Stripe Account! Be sure to create a new location."
    end
  end
end
