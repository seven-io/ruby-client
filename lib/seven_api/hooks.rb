# frozen_string_literal: true

# This module holds all utilities related to the /hooks endpoint.
module SevenApi::Hooks
  module Action
    READ = 'read'
    SUBSCRIBE = 'subscribe'
    UNSUBSCRIBE = 'unsubscribe'
  end

  module EventType
    ALL = 'all'
    NEW_INBOUND_SMS = 'sms_mo'
    RCS = 'rcs'
    SMS_STATUS_UPDATE = 'dlr'
    TRACKING = 'tracking'
    VOICE_CALL = 'voice_call'
    VOICE_DTMF = 'voice_dtmf'
    VOICE_STATUS_UPDATE = 'voice_status'
  end

  module RequestMethod
    GET = 'GET'
    JSON = 'JSON'
    POST = 'POST'
  end

  module Validator
    def self.validate(params)
      action = params[:action]

      raise "Unknown action #{action}" unless SevenApi::Hooks::Validator::is_action?(action)

      if SevenApi::Hooks::Action::SUBSCRIBE == action
        raise 'Parameter validation failed' unless SevenApi::Hooks::Validator::subscribe(params)
      elsif SevenApi::Hooks::Action::UNSUBSCRIBE == action
        raise 'ID must be a positive integer' unless SevenApi::Hooks::Validator::unsubscribe(params)
      end
    end

    def self.subscribe(params)
      { :request_method => SevenApi::Hooks::RequestMethod::POST }.merge!(params)

      self.event_type?(params[:event_type]) &&
        self.request_method?(params[:request_method]) &&
        self.target_url?(params[:target_url])
    end

    def self.unsubscribe(params)
      SevenApi::Util::is_positive_integer?(params[:id])
    end

    def self.is_action?(str)
      SevenApi::Util::in_module_constants?(str, SevenApi::Hooks::Action)
    end

    def self.event_type?(str)
      SevenApi::Util::in_module_constants?(str, SevenApi::Hooks::EventType)
    end

    def self.request_method?(str)
      SevenApi::Util::in_module_constants?(str, SevenApi::Hooks::RequestMethod)
    end

    def self.target_url?(str)
      SevenApi::Util::is_valid_url?(str)
    end
  end
end
