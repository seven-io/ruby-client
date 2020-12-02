# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'sms77'
require 'sms77/resource'
require 'sms77/util'
require 'matchers'
require 'EnvKeyStore'

SMS77_TEST_HTTP = (ENV['SMS77_TEST_HTTP'].nil? ? false : true).freeze

RSpec.configure do |config|
  SMS77_TEST_HTTP && config.after do
    sleep(1.125)
  end
end

class Helper
  attr_reader :resource

  IS_HTTP = SMS77_TEST_HTTP
  VIRTUAL_INBOUNDS = {
    eplus: '+491771783130',
  }.freeze

  # @param resource [Class<Sms77::Resource>]
  def initialize(resource)
    @resource = resource.new(ENV['SMS77_DUMMY_API_KEY'], 'ruby-test')

    unless Helper::IS_HTTP
      @stubs = Faraday::Adapter::Test::Stubs.new
      @resource.conn.builder.adapter(:test, @stubs)
    end
  end

  def create_stub(fn_name, stub)
    http_fn = @resource.http_methods[fn_name]
    puts "creating stub for #{http_fn} @ #{@resource.class.name}.#{fn_name}"

    @stubs.method(http_fn).call(Sms77::Resource::BASE_PATH + @resource.endpoint) do
      puts "stub: " + stub.inspect

      [200, {}, stub]
    end
  end

  def request(fn, stub, params = nil)
    create_stub(fn.name, stub) unless Helper::IS_HTTP

    fn.call(*[params].compact)
  end
end
