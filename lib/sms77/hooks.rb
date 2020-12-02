# frozen_string_literal: true

module Sms77::Hooks
  module Action
    READ = 'read'
    SUBSCRIBE = 'subscribe'
    UNSUBSCRIBE = 'unsubscribe'
  end

  module EventType
    NEW_INBOUND_SMS = 'sms_mo'
    SMS_STATUS_UPDATE = 'dlr'
    VOICE_STATUS_UPDATE = 'voice_status'
  end

  module RequestMethod
    GET = 'GET'
    POST = 'POST'
  end

  module Validator
    def self.validate(params)
      action = params[:action]

      raise "Unknown action #{action}" unless Sms77::Hooks::Validator::is_action?(action)

      if Sms77::Hooks::Action::SUBSCRIBE == action
        raise 'Parameter validation failed' unless Sms77::Hooks::Validator::subscribe(params)
      elsif Sms77::Hooks::Action::UNSUBSCRIBE == action
        raise 'ID must be a positive integer' unless Sms77::Hooks::Validator::unsubscribe(params)
      end
    end

    def self.subscribe(params)
      { :request_method => Sms77::Hooks::RequestMethod::POST }.merge!(params)

      self.event_type?(params[:event_type]) &&
        self.request_method?(params[:request_method]) &&
        self.target_url?(params[:target_url])
    end

    def self.unsubscribe(params)
      Sms77::Util::is_positive_integer?(params[:id])
    end

    def self.is_action?(str)
      Sms77::Util::in_module_constants?(str, Sms77::Hooks::Action)
    end

    def self.event_type?(str)
      Sms77::Util::in_module_constants?(str, Sms77::Hooks::EventType)
    end

    def self.request_method?(str)
      Sms77::Util::in_module_constants?(str, Sms77::Hooks::RequestMethod)
    end

    def self.target_url?(str)
      Sms77::Util::is_valid_url?(str)
    end
  end
end
