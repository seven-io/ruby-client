# frozen_string_literal: true

require 'seven_api/resource'

# This module exposes the methods for communicating with the API endpoint /validate_for_voice.
module SevenApi::Resources
  class ValidateForVoice < SevenApi::Resource
    @endpoint = SevenApi::Endpoint::VALIDATE_FOR_VOICE
    @http_methods = {
      :retrieve => :post,
    }

    # Validate a phone number for using it as caller ID via our voice API
    # read more: https://docs.seven.io/en/rest-api/endpoints/sender-identifiers#validate-sender-for-voice
    # @param params [Hash]
    # @return [Hash]
    def retrieve(params)
      request(params)
    end
  end
end