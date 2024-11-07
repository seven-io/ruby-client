# frozen_string_literal: true

require 'seven_api/resource'

# This module exposes the methods for communicating with the API endpoint /voice.
module SevenApi::Resources
  class Voice < SevenApi::Resource
    @endpoint = SevenApi::Endpoint::VOICE
    @http_methods = {
      :hangup => :post,
      :send => :post,
    }

    # This endpoint ends an active call. Only calls with the status in-progress can be ended.
    # read more: https://docs.seven.io/en/rest-api/endpoints/voice#hangup-a-call
    # @param call_id [String]
    # @return Hash
    def hangup(call_id)
      request({}, {}, "/#{call_id}/hangup")
    end

    # Convert text to speech, call number and read voice message out loud.
    # read more: https://docs.seven.io/en/rest-api/endpoints/voice#send-voice-call
    # @param params [Hash]
    # @return [String,Hash]
    def send(params)
      request(params)
    end
  end
end