module GithubApps
  class DefaultHandler
    attr_reader :hook, :action, :data, :client

    def initialize(hook, action, data, client)
      @hook = hook
      @action = action
      @data = data
      @client = client
    end

    def self.call(*args)
      new(*args).call
    end

    def call
      Rails.logger.warn <<~EOF
        Unhandled hook received: `#{hook}/#{action}`

        Data:
        #{data.pretty_inspect}
      EOF
    end
  end
end