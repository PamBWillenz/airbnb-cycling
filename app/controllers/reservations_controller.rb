class ReservationsController < ApplicationController
  before_action :authenticate_member!, only: [:new, :create, :confirmation]
  before_action :set_reservation, only: [:new, :create]

  def index
    @reservations = Reservation.where(member_id: current_member.id)
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
    respond_to do |format|
      if @reservation.save
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
end
