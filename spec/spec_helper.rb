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

RSpec::Matchers.define :be_lengthy do
  match do |value|
    return true if value.is_a?(String) && !Helper.client.sent_with.empty?
  end
end

class Helper
  @client = Sms77::Client.new(ENV['SMS77_DUMMY_API_KEY'], 'ruby-test')
  @is_http = ENV.key?('TEST_HTTP').freeze
  @stubs = Faraday::Adapter::Test::Stubs.new
  @virtual_inbound_nr_eplus = '+491771783130'
  @client.builder.adapter(:test, @stubs) unless @is_http

  @client.http_methods.each do |method|
    self.class.define_method(method.name) { |*args| request(@stubs.method(method.name.to_sym), *args) }
  end

  def self.request(method, endpoint, stub, params = {})
    unless @is_http
      method.call(@client.base_path + endpoint) { |_env| [200, {}, JSON.generate(stub)] }
    end

    args = [params] unless params.empty?
    @client.method(endpoint).call(*args)
  end

  class << self
    attr_reader :is_http, :virtual_inbound_nr_eplus, :client
  end
end
