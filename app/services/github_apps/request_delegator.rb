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
      GithubApps.const_get("#{hook.capitalize}#{action.capitalize}")
    rescue NameError
      DefaultHandler
    end
  end
end