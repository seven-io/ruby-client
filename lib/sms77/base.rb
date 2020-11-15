# frozen_string_literal: true

require 'cgi'
require 'json'
require 'faraday'
require 'sms77/endpoint'
require 'sms77/contacts_action'
require 'sms77/header'

module Sms77
  class Base
    def initialize(api_key, sent_with = 'ruby')
      raise 'missing api_key in config' if api_key.to_s.empty?
      raise 'missing sent_with in config' if sent_with.to_s.empty?

      @api_key = api_key
      @sent_with = sent_with
      @base_path = '/api/'.freeze

      @conn = Faraday.new("https://gateway.sms77.io#{@base_path}")
      @http_methods = [@conn.method(:get), @conn.method(:post)].freeze
      @conn.authorization :Bearer, @api_key
      @conn.headers['sentWith'] = @sent_with
      @conn.freeze
      @builder = @conn.builder

      @http_methods.each do |method|
        define_singleton_method(method.name) { |*args| request(method.name, *args) }
      end
    end

    attr_reader :builder, :api_key, :http_methods, :sent_with, :base_path

    protected

    def request(method, endpoint, params = {})
      if ENV['SMS77_DEBUG']
        puts "#{method} @ #{endpoint} with headers #{@conn.headers.inspect}"
        puts "url_prefix: #{@conn.url_prefix}"
        puts "built URL: #{@conn.build_url(endpoint)}"
        puts "exclusive URL: #{@conn.build_exclusive_url(endpoint)}"
      end

      res = @conn.run_request(method, endpoint, params, {})

      raise "Error requesting (#{self.class.name}) with code #{res.status}" unless 200 == res.status

      raise 'Unexpected response' unless res.is_a?(Faraday::Response)

      body = res.body

      begin
        body = JSON.parse(body)
      rescue StandardError
        # Ignored
      end

      puts "received: #{res.inspect}" if ENV['SMS77_DEBUG']

      body
    end
  end
end
