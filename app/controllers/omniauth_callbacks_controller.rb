class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def stripe_connect
    @member = current_member
    if @member.update_without_password({
      provider: request.env["omniauth.auth"].provider,
      stripe_user_id: request.env["omniauth.auth"].uid,
      stripe_access_token: request.env["omniauth.auth"].credentials.token,
      stripe_refresh_token: request.env["omniauth.auth"].credentials.token,
      stripe_publishable_key: request.env["omniauth.auth"].info.stripe_publishable_key
    })

    # anything else you need to do in response --

      redirect_to host_locations_path, notice: "Congrats on connecting your Stripe account!"
    else
      redirect_to payout_account_member_path(current_member), alert:
        "Please connect to stripe before you continue."
    end
  end
end
