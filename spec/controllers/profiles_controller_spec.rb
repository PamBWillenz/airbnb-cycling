require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do

  let(:member) {FactoryGirl.create(:member)}

  let(:valid_attributes) {
    {bio: FFaker::Lorem.paragraph(2), member_id: member.id}
    }
    let(:invalid_attributes) {
    {bio: nil , member_id: nil}
    }

  describe "GET #new" do
    it "assigns a new profile as @profile" do
      get :new, { :member_id => member.id}, valid_session
      expect(assigns(:profile)).to be_a_new(Profile)
    end
  end

  describe "GET #show" do
    it "assigns the requested profile as @profile" do
      get :show, {:member_id => member.id, :id => profile}
      expect(assigns(:profile)).to eq(profile)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Profile" do
        expect {
          post :create, { :member_id => member.id }, valid_session}.to change(Profile, :count).by(1)
      end

      it "assigns a newly created profile as @profile" do
        post :create, {:profile => valid_attributes}, valid_session
        expect(assigns(:profile)).to be_a(Profile)
        expect(assigns(:profile)).to be_persisted
      end

      it "redirects to the created profile" do
        post :create, {:profile => valid_attributes}, valid_session
        expect(response).to redirect_to(Profile.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved profile as @profile" do
        post :create, {:member_id => member.id, :profile => invalid_attributes}, valid_session
        expect(assigns(:profile)).to be_a_new(Profile)
      end

      it "re-renders the 'new' template" do
        post :create, {:profile => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end


  # describe "GET #edit" do
  #   it "assigns the requested profile as @profile" do
  #     profile = Profile.creat! valid_attributes
  #     get :edit { :member_id => member.id, :id => profile}
  #     expect(assigns(:profile)).to eq(profile)
  #   end
  # end

  # describe "GET #update" do
  #   it "returns http success" do
  #     get :update
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
