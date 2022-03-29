![](https://www.sms77.io/wp-content/uploads/2019/07/sms77-Logo-400x79.png "sms77 Logo")

# Ruby Client for the [sms77 SMS Gateway API](https://www.sms77.io/)
This gem requires Ruby >= 2.6.0.

## Installation

```gem install sms77```

### Usage

#### Retrieve balance

```ruby
require 'sms77/client'

api_key = ENV['SMS77_API_KEY']
# retrieve balance
puts Sms77::Resources::Balance.new(api_key).retrieve

# send SMS
puts Sms77::Resources::Sms.new(api_key).retrieve
```

#### Testing

```shell
SMS77_API_KEY=MySms77ApiKey bundle exec rspec
```

*Optional environment variables*

Setting ```SMS77_DEBUG=1``` prints details to stdout.

Setting ```SMS77_TEST_HTTP=1``` enables live testing with actual API requests.

##### Support

Need help? Feel free to [contact us](https://www.sms77.io/en/company/contact/).

[![MIT](https://img.shields.io/badge/License-MIT-teal.svg)](LICENSE)
