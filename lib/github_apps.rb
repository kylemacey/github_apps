require "jwt"
require "octokit"

require "github_apps/engine"
require "github_apps/config"

module GithubApps
  def self.config
    @config ||= Config.new
  end

  def self.configure
    yield(config)
  end

  def self.app_client
    @app_client ||= AppClientCreator.call(config)
  end
end
