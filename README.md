# GithubApps
A quick way to get started using GitHub Apps with your Rails app

## WARNING
This gem is not production ready and you should definitely not use it in production. Don't even look at it.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'github_apps'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install github_apps
```

## Configuration

Configure the following environment variables:

```shell
export GITHUB_APPS_WEBHOOK_SECRET= # Optional, webhook secret for your GitHub App
export GITHUB_APPS_PRIVATE_KEY_PATH= # Path on disk to your private key
export GITHUB_APPS_APP_IDENTIFIER= # The App ID for your GitHub app
```

You can also configure programmatically in an initializer:

```ruby
GithubApps.configure do |config|
  config.webhook_secret =
  config.private_key =
  config.app_identifier =
end
```

> **Note** if this repository has gone downhill and the documentation has fallen behind, you can probably find things in [lib/github_apps/config.rb](./lib/github_apps/config.rb) that look interesting

## Usage

Handle webhooks by creating service objects in `app/services/github_apps/`

```ruby
module GithubApps
  class IssuesOpened
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
      # Do stuff here...
    end
  end
end
```

## Contributing

Pull Requests welcome! Mention [@kylemacey](https://github.com/kylemacey) to get a review

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
