# frozen_string_literal: true

require 'sms77/resource'

# This module exposes the methods for communicating with the API endpoint /voice.
module Sms77::Resources
  class Voice < Sms77::Resource
    @endpoint = Sms77::Endpoint::VOICE
    @http_methods = {
      :send => :post,
    }

    # Convert text to speech, call number and read voice message out loud.
    # read more: https://www.sms77.io/en/docs/gateway/http-api/voice/
    # @param params [Hash]
    # @return [String,Hash]
    def send(params)
      request(params)
    end
  end
end