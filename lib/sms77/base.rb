# frozen_string_literal: true

require 'cgi'
require 'json'
require 'faraday'
require 'sms77/endpoint'

module Sms77
  class Base
    BASE_PATH = '/api/'
    CONN = Faraday.new("https://gateway.sms77.io#{BASE_PATH}")
    HTTP_GET = CONN.method(:get).freeze
    HTTP_POST = CONN.method(:post).freeze
    CONN.freeze
    HTTP_METHODS = [HTTP_GET, HTTP_POST].freeze
    BUILDER = CONN.builder

    def initialize(api_key, sent_with = 'ruby')
      raise 'missing api_key in config' if api_key.to_s.empty?
      raise 'missing sent_with in config' if sent_with.to_s.empty?

      @api_key = api_key
      @sent_with = sent_with

      HTTP_METHODS.each do |method|
        define_singleton_method(method.name) { |*args| request(method, *args) }
      end
    end

    attr_reader :api_key, :sent_with

    protected

    def request(method, path, payload = {})
      if !payload.empty? && HTTP_GET == method
        path = "#{path}?#{URI.encode_www_form(payload)}"

        payload = {}
      end

      method = method.name
      headers = Hash[
        Faraday::Request::Authorization::KEY, "Bearer #{@api_key}",
        'sentWith', @sent_with
      ]

      res = CONN.run_request(method, path, payload, headers)

      puts JSON.pretty_generate(res.to_hash.merge({
                                                    :method => method,
                                                    :path => path,
                                                    :payload => payload,
                                                    :req_headers => headers
                                                  }).compact) if ENV['SMS77_DEBUG']

      raise "Error requesting (#{self.class.name}) with code #{res.status}" unless 200 == res.status

      raise 'Unexpected response' unless res.is_a?(Faraday::Response)

      body = res.body

      if body.is_a?(String)
        begin
          body = JSON.parse(body, :symbolize_names => true)
        rescue StandardError
          # Ignored
        end
      end

      body.map! { |hash| hash.transform_keys(&:to_sym) } if body.is_a?(Array)

      body
    end
  end
end
