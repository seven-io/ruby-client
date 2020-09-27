# frozen_string_literal: true

require 'cgi'
require 'json'
require 'faraday'
require 'sms77/endpoint'
require 'sms77/contacts_action'
require 'sms77/header'

module Sms77
  class Client
    def initialize(api_key, conn, sent_with = 'ruby')
      @api_key = api_key
      @conn = conn
      @sent_with = sent_with

      raise 'missing api_key in config' if !@api_key || @api_key.empty?
      raise 'missing conn in config' unless @conn

      @conn.headers['sentWith'] = @sent_with
      @conn.authorization :Bearer, @api_key
    end

    BASE_URI = 'https://gateway.sms77.io'
    API_SUFFIX = '/api/'
    API_URI = "#{BASE_URI}#{API_SUFFIX}"

    def analytics(params = {})
      get(Sms77::Endpoint::ANALYTICS, params)
    end

    def balance
      get(Sms77::Endpoint::BALANCE)
    end

    def contacts(params)
      method(params['action'] == ContactsAction::READ ? 'get' : 'post').call(Sms77::Endpoint::CONTACTS, params)
    end

    def lookup(params)
      get(Sms77::Endpoint::LOOKUP, params)
    end

    def pricing(params = {})
      get(Sms77::Endpoint::PRICING, params)
    end

    def sms(params)
      post(Sms77::Endpoint::SMS, params)
    end

    def status(params)
      get(Sms77::Endpoint::STATUS, params)
    end

    def validate_for_voice(params)
      get(Sms77::Endpoint::VALIDATE_FOR_VOICE, params)
    end

    def voice(params)
      post(Sms77::Endpoint::VOICE, params)
    end

    private

    def get(endpoint, params = {})
      request(endpoint, 'get', params)
    end

    def post(endpoint, params)
      request(endpoint, 'post', params)
    end

    def request(endpoint, method, params)
      url = "#{API_SUFFIX}#{endpoint}"

      if ENV['SMS77_DEBUG']
        puts "requesting url: #{url}"
        puts "headers: #{@conn.headers.inspect}"
      end

      response = if method == 'get'
                   @conn.get(url, params)
                 else
                   @conn.post do |req|
                     req.path = url
                     req.params = params
                   end
                 end

      raise "Error requesting (#{self.class.name}) with code: #{response.status}" if response.status != 200

      puts "received body: #{response.body}" if ENV['SMS77_DEBUG']

      response
    end
  end
end
