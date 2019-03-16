# Preview all emails at http://localhost:3000/rails/mailers/customer_dispute
class CustomerDisputePreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/customer_dispute/send_admin_customer_dispute
  def send_admin_customer_dispute
    event = Stripe::Event.retrieve("evt_1EEd1tKGa7MvTac7cvoKcpPk")
    
    CustomerDisputeMailer.send_admin_customer_dispute(event)
  end
end
