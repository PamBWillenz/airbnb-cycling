class ReservationsController < ApplicationController
  before_action :authenticate_member!, only: [:new, :create, :confirmation]
  before_action :set_reservation, only: [:new, :create]

  def index
    @reservations = Reservation.where(member_id: current_member.id).where("start_date >=?", Date.today)
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
        @reservation.id_for_credit_charge = @customer_charge.id
      rescue Stripe::CardError => e 
        body = e.json_body
        message = body[:error][:message]
        flash[:alert] = message
      end
    else
      flash[:alert] = "Some of the dates of your reservation are not available. Please try different dates."
    end

    respond_to do |format|
      if !@customer_charge.nil?
        @reservation.save
        @reservation.dates_booked
        format.html { redirect_to confirmation_reservation_path(@reservation), notice: "Reservation successfully created." }
      else
        format.html { redirect_to location_path(@location), alert: "Some of your dates on your reservation are not available. Please try different dates." }
      end
    end
  end

  def confirmation
    @reservation = Reservation.find(params[:id])
    @location = @reservation.location
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
end
