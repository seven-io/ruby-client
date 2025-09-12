<img alt="" src="https://www.seven.io/wp-content/uploads/Logo.svg" width="250" />

# Official Ruby Client for [seven.io](https://www.seven.io/)
This gem requires Ruby >= 3.1.0.

## Installation

```gem install seven_api```

### Usage

#### Basic Usage

```ruby
require 'seven_api/client'

api_key = ENV['SEVEN_API_KEY']

# Using individual resources
balance = SevenApi::Resources::Balance.new(api_key).retrieve
puts balance

# Send SMS
sms_result = SevenApi::Resources::Sms.new(api_key).retrieve({ 
  text: 'Hello World', 
  to: '1234567890' 
})
puts sms_result

# Using the client (recommended)
client = SevenApi::Client.new(api_key)
puts client.Balance.retrieve
puts client.Sms.retrieve({ text: 'Hello World', to: '1234567890' })
```

#### HMAC Request Signing

For enhanced security, you can enable HMAC-SHA256 request signing:

```ruby
require 'seven_api/client'

api_key = ENV['SEVEN_API_KEY']
signing_secret = ENV['SEVEN_SIGNING_SECRET']

# Using individual resources with HMAC
sms = SevenApi::Resources::Sms.new(api_key, 'ruby', signing_secret)
result = sms.retrieve({ text: 'Hello World', to: '1234567890' })

# Using the client with HMAC (recommended)
client = SevenApi::Client.new(api_key, 'ruby', signing_secret)
result = client.Sms.retrieve({ text: 'Hello World', to: '1234567890' })
```

When HMAC signing is enabled, each request includes:
- `X-Timestamp`: Unix timestamp of the request
- `X-Signature`: HMAC-SHA256 signature of the request data

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
