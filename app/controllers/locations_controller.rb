class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy, :add_images, :remove_images, :calendar, :add_available_dates]
  before_action :authenticate_member!, only: [:new, :edit, :create, :update, :show, :destroy, :add_images, :calendar, :add_available_dates]

  def index
    if params[:commit].present?
    # if params [:start_date].present? || params[:end_date].present? || params[:address].present? || params[:bike_type].present? || params[:guests].present?
      @locations = SearchForLocationService.new({
        start_date: params[:start_date],
        end_date: params[:end_date],
        address: params[:address],
        bike_type: params[:bike_type],
        guests: params[:guests]
        }).matches.includes(:location_images, :member).page(params[:page]).per(2)
    else
    @locations = Location.all.includes(:location_images, :member).page(params[:page]).per(2)
    end
  end

  def show
    @location_images = @location.location_images.all
    @coordinates = {lng: @location.longitude, lat: @location.latitude, radius: 800}
  end

  def new
    @location = Location.new
  end

  def edit
    authorize @location
  end

  def create
    @location = Location.new(location_params)

    respond_to do |format|

      if @location.save
        format.html { redirect_to add_images_location_path(@location), notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @location
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @location
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_images
    @location_images = @location.location_images.all
  end

  def remove_images
    @location_image = LocationImage.find(params[:image_id])
      @location_image.destroy
    respond_to do |format|
      format.html { redirect_to add_images_location_path(@location), notice: 'Location image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def calendar
    authorize @location
    @reservations = Reservation.upcoming.where(location: @location)
  end

  def add_available_dates
    @location.create_available_dates(params[:start_date], params[:end_date])
    redirect_to calendar_location_path(@location), notice: "Successfully added available dates"
  end

  def host_locations
    @locations = current_member.locations.includes(:location_images)
  end

  private

    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:title, :description, :address_1, :address_2, :city, 
        :state, :postcode, :bike_type, :guests, :price, :member_id, 
        location_images_attributes: [:id, :picture, :picture_order, :_destroy, :location_id])
    end
end
