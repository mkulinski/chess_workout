require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  describe "Action: games#index" do
    it "should successfully show the index page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
