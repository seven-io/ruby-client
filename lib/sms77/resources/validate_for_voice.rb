# frozen_string_literal: true

require 'sms77/resource'

# This module exposes the methods for communicating with the API endpoint /validate_for_voice.
module Sms77::Resources
  class ValidateForVoice < Sms77::Resource
    @endpoint = Sms77::Endpoint::VALIDATE_FOR_VOICE
    @http_methods = {
      :retrieve => :post,
    }

    # Validate a phone number for using it as caller ID via our voice API
    # read more: https://www.sms77.io/en/docs/gateway/http-api/caller-ids/
    # @param params [Hash]
    # @return [Hash]
    def retrieve(params)
      request(params)
    end
  end
end