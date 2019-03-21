require 'rails_helper'
require 'stripe_mock' 

describe "Customer Dispute Events", :live => true do

  describe "charge.dispute.created", :live => true do 
    #let(:params) { stripe_helper.create_plan_params }
    
    before do
      StripeMock.start
      @event = StripeMock.mock_webhook_event('charge.dispute.created')
      # @event = Stripe::Event.retrieve("evt_1EEd1tKGa7MvTac7cvoKcpPk")
      ActionMailer::Base.deliveries.clear
    end
  
    after do 
      StripeMock.stop
      ActionMailer::Base.deliveries.clear
    end

    it "is successful", :live => true do 
      # @event = Stripe::Event.retrieve("evt_1EEd1tKGa7MvTac7cvoKcpPk")
      post '/stripe-web-hooks', params: { id: @event.id }
      expect(response.code).to eq "200"
    end

    it "sends an email to the admin", :live => true do
      post '/stripe-web-hooks', params: { id: @event.id }
      expect(ActionMailer::Base.deliveries.count).to eq 1
    end
  end
end
