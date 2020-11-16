# frozen_string_literal: true

require 'cgi'
require 'json'
require 'faraday'
require 'sms77/endpoint'
require 'sms77/contacts_action'
require 'sms77/header'

module Sms77
  class Base
    BASE_PATH = '/api/'.freeze
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

      CONN.authorization :Bearer, @api_key
      CONN.headers['sentWith'] = @sent_with

      HTTP_METHODS.each do |method|
        define_singleton_method(method.name) { |*args| request(method, *args) }
      end
    end

    attr_reader :builder, :api_key, :http_methods, :sent_with, :base_path

    protected

    def request(method, path, payload = {})
      if !payload.empty? && HTTP_GET == method
        path = "#{path}?#{URI.encode_www_form(payload)}"

        payload = {}
      end

      res = CONN.run_request(method.name, path, payload, {})

      puts res.inspect if ENV['SMS77_DEBUG']

      raise "Error requesting (#{self.class.name}) with code #{res.status}" unless 200 == res.status

      raise 'Unexpected response' unless res.is_a?(Faraday::Response)

      begin
         JSON.parse(res.body)
      rescue StandardError
        res.body
      end
    end
  end
end
