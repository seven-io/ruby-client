# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'seven_api'
require 'seven_api/resource'
require 'seven_api/util'
require 'matchers'
require 'EnvKeyStore'

class Helper
  attr_reader :resource

  IS_HTTP = (ENV['SEVEN_TEST_HTTP'].nil? ? false : true).freeze
  VIRTUAL_INBOUNDS = {
    eplus: '+491771783130',
  }.freeze

  # @param resource [Class<SevenApi::Resource>]
  def initialize(resource)
    @resource = resource.new(ENV['SEVEN_API_KEY'], 'ruby-test')

    unless Helper::IS_HTTP
      @stubs = Faraday::Adapter::Test::Stubs.new
      @resource.conn.builder.adapter(:test, @stubs)
    end
  end

  def create_stub(fn_name, stub, path)
    http_fn = @resource.http_methods[fn_name]
    puts "creating stub for #{http_fn} @ #{@resource.class.name}.#{fn_name}"

    @stubs.method(http_fn).call(SevenApi::Resource::BASE_PATH + @resource.endpoint + path) do
      puts "stub: " + stub.inspect

      [200, {}, stub]
    end
  end

  def request(fn, stub, params = nil, path = '')
    create_stub(fn.name, stub, path) unless Helper::IS_HTTP

    fn.call(*[params].compact)
  end
end
