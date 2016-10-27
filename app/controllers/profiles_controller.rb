class ProfilesController < ApplicationController
  def new
    @profile = current_member.build_profile
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def create
    @profile = current_member.create_profile(profile_params)
    if @profile.save
      redirect_to member_profile_path(current_member, @profile), notice: "You successfully created your profile."
    else
      flash[:alert] = "Could not create your profile."
      render :new
    end
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      redirect_to member_profile_path(current_member, @profile), notice: "You successfully updated your profile."
    else
      flash[:alert] = "Could not update profile."
      render :edit
  end
end

private

  def profile_params
    params.required(:profile).permit(:name, :bio, :member_id, :profile_pic)
  end
end
