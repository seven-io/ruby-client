# frozen_string_literal: true

require 'sms77/resource'

# This module exposes the methods for communicating with the API endpoint /sms.
module Sms77::Resources
  class Sms < Sms77::Resource
    @endpoint = Sms77::Endpoint::SMS
    @http_methods = {
      :retrieve => :post,
    }

    # Send SMS
    # read more: https://www.sms77.io/en/docs/gateway/http-api/sms-dispatch/
    # @param params [Hash]
    # @return [Integer,String,Hash]
    def retrieve(params)
      request(params)
    end
  end
end