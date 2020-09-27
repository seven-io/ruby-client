![](https://www.sms77.io/wp-content/uploads/2019/07/sms77-Logo-400x79.png "Sms77.io Logo")

# Sms77.io SMS Gateway API Client

## Installation

```gem install sms77```

### Usage

```ruby
client = Sms77::Client.new(api_key: ENV['SMS77_API_KEY'])
balance = client.get(url: '/api/balance')
puts balance.inspect
```