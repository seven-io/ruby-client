# frozen_string_literal: true

require 'sms77/resource'

# This module exposes the methods for communicating with the API endpoint /pricing.
module Sms77::Resources
  class Pricing < Sms77::Resource
    @endpoint = Sms77::Endpoint::PRICING
    @http_methods = {
      :retrieve => :get,
    }

    # Retrieve pricing
    # read more: https://www.sms77.io/en/docs/gateway/http-api/pricing/
    # @param params [Hash]
    # @return [Hash,String]
    def retrieve(params = {})
      request(params)
    end
  end
end