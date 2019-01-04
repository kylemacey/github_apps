module GithubApps
  class AppClientCreator
    attr_reader :config

    def initialize(config)
      @config = config
    end

    def self.call(*args)
      new(*args).call
    end

    ##
    # Returns an Octokit client authenticated as the app
    def call
      jwt = JWT.encode(payload, config.private_key, 'RS256')
      Octokit::Client.new(bearer_token: jwt)
    end

    private

    def payload
      {
        # The time that this JWT was issued, _i.e._ now.
        iat: Time.now.to_i,

        # JWT expiration time (10 minute maximum)
        exp: Time.now.to_i + (10 * 60),

        # Your GitHub App's identifier number
        iss: config.app_identifier
      }
    end
  end
end