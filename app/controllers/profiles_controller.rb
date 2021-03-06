class ProfilesController < ApplicationController
  before_action :set_member, except: :index
  before_action :authenticate_member!

  def index
    @profiles = Profile.all 
  end

  def new
    @profile = @member.build_profile
    authorize @profile
  end

  def show
    @profile = Profile.find(params[:id])
    authorize @profile
  end

  def create
    @profile = @member.create_profile(profile_params)
    authorize @profile
    if @profile.save
      redirect_to member_profile_path(@member, @profile), notice: "You successfully created your profile."
    else
      flash[:alert] = "Could not create your profile."
      render :new
    end
  end

  def edit
    @profile = Profile.find(params[:id])
    authorize @profile
  end

  def update
    @profile = Profile.find(params[:id])
    authorize @profile
    if @profile.update(profile_params)
      redirect_to member_profile_path(@member, @profile), notice: "You successfully updated your profile."
    else
      flash[:alert] = "Could not update profile."
      render :edit
  end
end

private

  def profile_params
    params.required(:profile).permit(:name, :bio, :member_id, :profile_pic)
  end

  def set_member
    @member = Member.find(params[:member_id])
  end
end
