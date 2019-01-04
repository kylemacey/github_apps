require "spec_helper"

module GithubApps
  RSpec.describe RequestDelegator do
    it "uses the default handler for actions not defined" do
      expect(DefaultHandler).to receive(:call)

      described_class.call("fake", "event", {})
    end

    it "calls the appropriate service" do
      expect(IssuesOpened).to receive(:call)

      described_class.call("issues", "opened", {})
    end
  end
end