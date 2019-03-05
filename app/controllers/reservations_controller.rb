class ReservationsController < ApplicationController
  before_action :authenticate_member!, only: [:new, :create, :confirmation]
  before_action :set_reservation, only: [:new, :create]

  def index
    @reservations = Reservation.where(member_id: current_member.id).where("start_date >=?", Date.today).where(id_for_refund: nil)
    #@reservations = Reservation.upcoming_for_member(member: current_member)
  end

  def new
    respond_to do |format|
      if @reservation.start_date.nil? || @reservation.end_date.nil?
        format.html { redirect_to location_path(@location), alert: "Please select dates for Check in and Check out." }
      else
        @location = @reservation.location
        @available_dates = @location.available_dates.where(booked: false).pluck(:available_date).as_json
        format.html { render :new }
      end
    end
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @token = params[:stripe_token]

    if @reservation.valid?
      begin
        @customer_charge = charge_customer(@token, @location, @reservation)
        @reservation.customer_charge_id = @customer_charge.id
        @reservation.save
        @reservation.dates_booked 
        redirect_to confirmation_reservation_path(@reservation), notice: "Reservation successfully created."
      rescue Stripe::CardError => e 
        body = e.json_body
        message = body[:error][:message]
        redirect_to location_path(@location), alert: message
      end
    else
      redirect_to location_path(@location), alert: "Some of the dates of your reservation are not available. Please try different dates." 
    end
  end

  def confirmation
    @reservation = Reservation.find(params[:id])
    @location = @reservation.location
  end

  def cancel
    @reservation = Reservation.find(params[:id])
     begin
       refund = refund_customer(@reservation)
       @id_for_refund = refund[:refunds][:data][0][:id]
     rescue Stripe::StripeError => e
       body = e.json_body
       message = body[:error][:message]
       flash[:alert] =  message
      end
     if !@id_for_refund.nil?
       @reservation.update_after_refund(@id_for_refund)
       redirect_to reservations_path, notice: "Your reservation was successfully cancelled." 
     else
       redirect_to reservations_path
     end
  end

  private

  def set_reservation
    @reservation = Reservation.new(reservation_params)
    @location = @reservation.location
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date, :location_id, :member_id)
  end

  def charge_customer(source, location, reservation)
    CreditCardService.new({
      source: source,
      location: location,
      reservation: reservation
    }).charge_customer
  end

  def refund_customer(reservation)
    CreditCardService.new({ reservation: reservation}).refund_customer
  end
end
