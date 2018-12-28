require "spec_helper"

module GithubApps
  RSpec.describe EventsController, type: :controller do

    describe "GET #receive" do
      it "returns http success" do
        get :receive
        expect(response).to have_http_status(:success)
      end
    end

  end
end
