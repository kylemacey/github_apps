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

Configure GithubApps to respond to webhook events in your initializer.

```ruby
GithubApps.configure do |config|
  config.handlers["issues/opened"] = IssuesOpened
end
```

If you override the entire configuration hash, it's a good idea to specify a default.

```ruby
GithubApps.configure do |config|
  config.handlers = { "issues/opened" => IssuesOpened }

  # Use github_apps default event handler which logs unhandled webhooks
  config.handlers.default(GithubApps::DefaultHandler)
end
```

Whichever class you specify will use the class method `.call` and pass in information for you to process. Since these arguments might change frequently in early development, it might be worth looking at the [`RequestDelegator`](./app/services/github_apps/request_delegator.rb) and the [`DefaultHandler`](./app/services/github_apps/default_handler.rb).

## Contributing

Pull Requests welcome! Mention [@kylemacey](https://github.com/kylemacey) to get a review

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
