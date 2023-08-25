# frozen_string_literal: true

require 'seven_api/resource'

# This module exposes the methods for communicating with the API endpoint /sms.
module SevenApi::Resources
  class Sms < SevenApi::Resource
    @endpoint = SevenApi::Endpoint::SMS
    @http_methods = {
      :retrieve => :post,
    }

    # Send SMS
    # read more: https://www.seven.io/en/docs/gateway/http-api/sms-dispatch/
    # @param params [Hash]
    # @return [Integer,String,Hash]
    def retrieve(params)
      request(params)
    end
  end
end