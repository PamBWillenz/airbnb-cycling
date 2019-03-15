class CustomerDisputeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.customer_dispute_mailer.send_admin_customer_dispute.subject
  #
  def send_admin_customer_dispute(event)
    @event = event

    mail(to: "admin@rubythursday.com", subject: "Uh oh, a customer has submitted a dispute", from: "melissa@rubythursday.com")

  end
end
