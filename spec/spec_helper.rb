# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'seven_api'
require 'seven_api/resource'
require 'seven_api/util'
require 'matchers'
require 'EnvKeyStore'

SEVEN_TEST_HTTP = (ENV['SEVEN_TEST_HTTP'].nil? ? false : true).freeze

RSpec.configure do |config|
  SEVEN_TEST_HTTP && config.after do
    sleep(1.125)
  end
end

class Helper
  attr_reader :resource

  IS_HTTP = SEVEN_TEST_HTTP
  VIRTUAL_INBOUNDS = {
    eplus: '+491771783130',
  }.freeze

  # @param resource [Class<SevenApi::Resource>]
  def initialize(resource)
    @resource = resource.new(ENV['SEVEN_API_KEY_SANDBOX'], 'ruby-test')

    unless Helper::IS_HTTP
      @stubs = Faraday::Adapter::Test::Stubs.new
      @resource.conn.builder.adapter(:test, @stubs)
    end
  end

  def create_stub(fn_name, stub)
    http_fn = @resource.http_methods[fn_name]
    puts "creating stub for #{http_fn} @ #{@resource.class.name}.#{fn_name}"

    @stubs.method(http_fn).call(SevenApi::Resource::BASE_PATH + @resource.endpoint) do
      puts "stub: " + stub.inspect

      [200, {}, stub]
    end
  end

  def request(fn, stub, params = nil)
    create_stub(fn.name, stub) unless Helper::IS_HTTP

    fn.call(*[params].compact)
  end
end
