module GithubApps
  class Engine < ::Rails::Engine
    isolate_namespace GithubApps

    config.generators do |g|
      g.test_framework :rspec, :fixture => false
      g.assets false
      g.helper false
      g.template_engine  false
    end
  end
end
