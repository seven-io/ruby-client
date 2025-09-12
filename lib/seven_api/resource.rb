# frozen_string_literal: true

require 'cgi'
require 'json'
require 'faraday'
require 'openssl'
require 'seven_api/endpoint'
require 'securerandom'
require 'digest/md5'

# This module exposes a HTTP client for communication with the API.
module SevenApi
  class Resource
    attr_reader :api_key, :endpoint, :sent_with, :http_methods, :request_methods, :builder, :conn, :signing_secret

    BASE_PATH = '/api/'
    API_PATH = "https://gateway.seven.io#{BASE_PATH}"

    def initialize(api_key, sent_with = 'ruby', signing_secret = nil)
      raise 'missing api_key in config' if api_key.to_s.empty?
      raise 'missing sent_with in config' if sent_with.to_s.empty?

      @api_key = api_key
      @sent_with = sent_with
      @signing_secret = signing_secret
      @endpoint = self.class.get_endpoint
      @http_methods = self.class.get_http_methods
      @conn = Faraday.new(API_PATH)
    end

    protected

    def request(http_method, payload = {}, query = {}, path = '')
      path = "#{@endpoint}#{path}"

      if :get == http_method
        query = payload

        payload = {}
      end

      query.each do |key, val|
        query.store(key, SevenApi::Util::to_numbered_bool(val))
      end

      payload.each do |key, val|
        payload.store(key, SevenApi::Util::to_numbered_bool(val))
      end

      unless query.empty?
        path = "#{path}?#{URI.encode_www_form(query)}"
      end

      headers = Hash[
        'Accept', 'application/json',
        'sentWith', @sent_with
      ]
      if @api_key.start_with?('Bearer ')
        headers.store(Faraday::Request::Authorization::KEY, @api_key)
      else
        headers.store('X-Api-Key', @api_key)
      end

      if @signing_secret != nil
        timestamp = Time.now.to_i.to_s
        headers.store('X-Timestamp', timestamp)

        puts timestamp
        path = "#{API_PATH}#{path}"
        puts path
        method_str = http_method.to_s.upcase
        puts method_str
        payload_str = payload.empty? ? '' : payload.to_json
        puts payload_str
        payload_str = Digest::MD5.hexdigest(payload_str)
        nonce = SecureRandom.hex
        puts nonce.length
        signature_data = "#{timestamp}\n#{nonce}\n#{method_str}\n#{path}\n#{payload_str}"


        signature = OpenSSL::HMAC.hexdigest('SHA256', @signing_secret, signature_data)
        headers.store('X-Signature', signature)
      end

      res = @conn.run_request(http_method, path, payload, headers)

      puts JSON.pretty_generate(res.to_hash.merge({
                                                    :method => http_method,
                                                    :path => path,
                                                    :payload => payload,
                                                    :req_headers => headers,
                                                    :query => query,
                                                  }).compact) if ENV['SEVEN_DEBUG']

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

    private

    class << self
      def get_http_methods
        @http_methods
      end

      def get_endpoint
        @endpoint
      end
    end
  end
end
