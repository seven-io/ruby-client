![Sms77.io Logo](https://www.sms77.io/wp-content/uploads/2019/07/sms77-Logo-400x79.png "Sms77.io Logo")

# Ruby Client for the Sms77.io SMS Gateway API

## Installation

```gem install sms77```

### Usage

```ruby
require 'sms77'

puts Sms77::Client.new(Sms77::Resource(ENV['SMS77_API_KEY'])).Balance.retrieve
# or
puts Sms77::Resources::Balance.new(ENV['SMS77_API_KEY']).retrieve
```

#### Testing

```shell
SMS77_API_KEY=MySms77ApiKey bundle exec rspec
```

*Optional environment variables*

Setting ```SMS77_DEBUG=1``` prints details to stdout.

Setting ```SMS77_TEST_HTTP=1``` enables live testing with actual API requests.

##### Support

Need help? Feel free to send us an <a href='mailto: support@sms77.io'>email</a>.