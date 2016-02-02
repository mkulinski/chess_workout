require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe "Action: games#index" do
    it "should successfully show the index page" do
      user = FactoryGirl.create(:user)
      sign_in user
      get :index
      expect(response).to have_http_status(:success)
    end

    it "should require sign in" do
      get :index
      expect(response).to redirect_to new_user_session_path
    end
  end
end
