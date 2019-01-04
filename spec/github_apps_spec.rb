require "spec_helper"

RSpec.describe GithubApps do
  describe "#config" do
    subject(:config) { described_class.config }

    it "returns the config object for the app" do
      expect(config).to be_a(GithubApps::Config)
    end
  end

  describe "#configure" do
    let(:mock_config) { double("config") }

    before do
      # We don't want to mess around with the actual app configuration in here
      allow(GithubApps).to receive(:config).and_return(mock_config)
    end

    it "sets configuration options" do
      expect(mock_config).to receive(:option=).with("foobar")

      GithubApps.configure do |c|
        c.option = "foobar"
      end
    end
  end
end