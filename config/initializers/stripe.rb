Stripe.api_key = ENV["stripe_secret_key"]
StripeEvent.signing_secret = "whsec_GZE4akyF9TH9g02wppEJtYpHK7PewWBC"

# StripeEvent.configure do |events| 
#   events.subscribe 'charge.dispute.created' do |event| 

StripeEvent.subscribe 'charge.dispute.created' do |event|
  event.class       #=> Stripe::Event
  event.type        #=> "charge.dispute.created"
  event.data.object #=> #<Stripe::Charge:0x3fcb34c115f8>
  # end
CustomerDisputeMailer.send_admin_customer_dispute(event).deliver_now
end
