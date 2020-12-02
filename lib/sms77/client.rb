# frozen_string_literal: true

require 'cgi'
require 'json'
require 'faraday'
require 'sms77/endpoint'
require 'sms77/contacts'
require 'sms77/base'

module Sms77
  class Client < Sms77::Base
    def analytics(params = {})
      get(Sms77::Endpoint::ANALYTICS, params)
    end

    def balance
      get(Sms77::Endpoint::BALANCE)
    end

    def contacts(params)
      get_or_post(Sms77::Contacts::Action::READ == params[:action], Sms77::Endpoint::CONTACTS, params)
    end

    def hooks(params)
      Sms77::Hooks::Validator::validate(params)

      get_or_post(Sms77::Hooks::Action::READ == params[:action], Sms77::Endpoint::HOOKS, params)
    end

    def journal(params)
      get(Sms77::Endpoint::JOURNAL, params)
    end

    def lookup(params)
      post(Sms77::Endpoint::LOOKUP, params)
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
      post(Sms77::Endpoint::VALIDATE_FOR_VOICE, params)
    end

    def voice(params)
      post(Sms77::Endpoint::VOICE, params)
    end

    private

    def get_or_post(bool, *args)
      method(bool ? :get : :post).call(*args)
    end
  end
end
