require "spec_helper"

RSpec.describe "Events Callback", type: :request do
  let(:route) { "/github_apps/events/receive" }

  context "when provided bad JSON" do
    let(:params) { "lorem ipsum" }

    it "returns a 400" do
      post(route, params: params)

      expect(response.status).to eq(400)
    end

    it "gives a useful error" do
      post(route, params: params)

      json = JSON.parse(response.body)

      expect(json["message"]).to eq("Request body contained invalid JSON")
    end
  end
end