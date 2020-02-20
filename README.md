# Rack::Ignore::Request

Some request checks the status of the apps x per seconds. To prevent these requests from clutter up the log file this gem ignores these.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-ignore-request', git: 'git@vcs.holder.nl:holder/rack-ignore-request.git'
```

And then execute:

    $ bundle

## Usage

Add the following line to load the middleware

```ruby
config.middleware.insert_before Rails::Rack::Logger, Rack::IgnoreRequest
```

Default path for ignored requests is `/monitor` if you want to change this path add the following to the `/initializers/rack_ignore_request.rb` file

```ruby
Rack::IgnoreRequest.configure do |config|
  config.ignore_path = '/ignore_path'
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitLab at https://vcs.holder.nl/holder/rack-ignore-request
