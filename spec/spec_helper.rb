# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'sms77'

RSpec::Matchers.define :be_boolean do
  match do |value|
    [true, false].include? value
  end
end

RSpec::Matchers.define :be_numeric do
  match do |value|
    return true if value.is_a?(Integer)

    value.scan(/\D/).empty?
  end
end

class Helper
  @is_http = ENV.key?('TEST_HTTP')
  @stubs = Faraday::Adapter::Test::Stubs.new
  @conn = Faraday.new(Sms77::Client::BASE_URI) do |b|
    b.adapter(:test, @stubs) unless @is_http
  end
  @client = Sms77::Client.new(ENV['SMS77_DUMMY_API_KEY'], @conn, 'ruby-test')
  @virtual_inbound_nr_eplus = '+491771783130'

  def self.request(endpoint, params, stub, extra_params = {})
    path = "#{Sms77::Client::API_SUFFIX}#{endpoint}"

    # TODO-START: determine request method to avoid multiple useless stubs
    @stubs.get(path) { |_env| [200, {}, JSON.generate(stub)] } unless @is_http
    @stubs.post(path) { |_env| [200, {}, JSON.generate(stub)] } unless @is_http
    # TODO-END

    response = @client.method(endpoint).call(params.merge(extra_params))

    raise 'unexpected response' unless Faraday::Response == response.class

    body = response.body

    begin
      body = JSON.parse(body)
    rescue StandardError
      # Ignored
    end

    body
  end

  class << self
    attr_reader :is_http, :stubs, :conn, :client, :virtual_inbound_nr_eplus
  end
end
