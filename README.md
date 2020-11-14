![Sms77.io Logo](https://www.sms77.io/wp-content/uploads/2019/07/sms77-Logo-400x79.png "Sms77.io Logo")

# Ruby Client for the Sms77.io SMS Gateway API

## Installation

```gem install sms77```

### Usage

```ruby
require 'sms77'

client = Sms77::Client.new(ENV['SMS77_API_KEY'])

puts "Balance: #{client.balance.body}"
```