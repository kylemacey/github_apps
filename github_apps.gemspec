$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "github_apps/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "github_apps"
  spec.version     = GithubApps::VERSION
  spec.authors     = ["Kyle Macey"]
  spec.email       = ["kylemacey@github.com"]
  spec.homepage    = "https:TODO.example.com"
  spec.summary     = "A quick way to hook your app up to GitHub Apps"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  spec.test_files = Dir["spec/**/*"]

  spec.add_dependency "rails", "~> 5.2.2"

  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "capybara"
  spec.add_development_dependency "pry-rails"
end
