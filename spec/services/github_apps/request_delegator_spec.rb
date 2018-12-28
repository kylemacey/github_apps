require "spec_helper"

module GithubApps
  RSpec.describe RequestDelegator do
    it "calls the appropriate service" do
      expect(IssuesOpened).to receive(:call)

      described_class.call("issues", "opened", {})
    end
  end
end