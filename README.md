![](https://www.seven.io/wp-content/uploads/Logo.svg "seven Logo")

# Ruby Client for the [seven SMS Gateway API](https://www.seven.io/)
This gem requires Ruby >= 2.6.0.

## Installation

```gem install seven_api```

### Usage

#### Retrieve balance

```ruby
require 'seven_api/client'

api_key = ENV['SEVEN_API_KEY']
# retrieve balance
puts SevenApi::Resources::Balance.new(api_key).retrieve

# send SMS
puts SevenApi::Resources::Sms.new(api_key).retrieve
```

#### Testing

```shell
SEVEN_API_KEY=MySevenApiKey bundle exec rspec
```

*Optional environment variables*

Setting ```SEVEN_DEBUG=1``` prints details to stdout.

Setting ```SEVEN_TEST_HTTP=1``` enables live testing with actual API requests.

##### Support

Need help? Feel free to [contact us](https://www.seven.io/en/company/contact/).

[![MIT](https://img.shields.io/badge/License-MIT-teal.svg)](LICENSE)
