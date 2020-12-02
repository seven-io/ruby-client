# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'sms77'
require 'sms77/util'

RSpec::Matchers.define :be_nil_or_lengthy_string do
  match do |val|
    Sms77::Util::nil_or_lengthy_string?(val)
  end
end

RSpec::Matchers.define :be_boolean do
  match do |val|
    Sms77::Util::boolean?(val)
  end
end

RSpec::Matchers.define :be_numeric do
  match do |val|
    Sms77::Util::numeric?(val)
  end
end

RSpec::Matchers.define :be_lengthy_string do
  match do |val|
    Sms77::Util::lengthy_string?(val)
  end
end

class EnvKeyStore
  def initialize(key)
    @key = "SMS77_TEST_#{key}"

    @store = ENV[@key]
  end

  def get(fallback = nil)
    @store.nil? ? fallback : @store
  end

  def set(val, only_on_nil = false)
    @store = val unless only_on_nil
  end
end

class Helper
  @client = Sms77::Client.new(ENV['SMS77_DUMMY_API_KEY'], 'ruby-test')
  @is_http = ENV['SMS77_TEST_HTTP'].freeze
  @stubs = Faraday::Adapter::Test::Stubs.new
  @virtual_inbound_nr_eplus = '+491771783130'
  Sms77::Client::BUILDER.adapter(:test, @stubs) unless @is_http

  Sms77::Client::HTTP_METHODS.each do |method|
    self.class.define_method(method.name) { |*args| request(@stubs.method(method.name.to_sym), *args) }
  end

  def self.request(method, endpoint, stub, params = nil)
    method.call(Sms77::Client::BASE_PATH + endpoint) { || [200, {}, stub] } unless @is_http

    @client.method(endpoint).call(*[params].compact)
  end

  class << self
    attr_reader :is_http, :virtual_inbound_nr_eplus, :client
  end
end
