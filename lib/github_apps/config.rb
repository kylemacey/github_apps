module GithubApps
  class Config
    attr_accessor :webhook_secret, :private_key, :private_key_path,
      :app_identifier

    def webhook_secret
      @webhook_secret ||= ENV["GITHUB_APPS_WEBHOOK_SECRET"]
    end

    def private_key
      @private_key ||= OpenSSL::PKey::RSA.new(File.read(private_key_path))
    end

    def private_key_path
      @private_key_path ||= ENV["GITHUB_APPS_PRIVATE_KEY_PATH"]
    end

    def app_identifier
      @app_identifier ||= ENV["GITHUB_APPS_APP_IDENTIFIER"]
    end
  end
end