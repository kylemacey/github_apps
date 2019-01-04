module GithubApps
  class RequestDelegator
    attr_reader :hook, :action, :data

    def self.call(*args)
      new(*args).call
    end

    def initialize(hook, action, data)
      @hook   = hook
      @action = action
      @data   = data
    end

    def call
      handler_class.call(hook, action, data, nil)
    end

    private

    def handler_class
      handler_path = File.join(hook, action)
      GithubApps.config.handlers[handler_path]
    end
  end
end