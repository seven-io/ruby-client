# frozen_string_literal: true

require 'sms77/resource'

module Sms77::Resources
  class ValidateForVoice < Sms77::Resource
    @endpoint = Sms77::Endpoint::VALIDATE_FOR_VOICE
    @http_methods = {
      :retrieve => :post,
    }

    def retrieve(params)
      request(params)
    end
  end
end