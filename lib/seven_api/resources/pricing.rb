# frozen_string_literal: true

require 'seven_api/resource'

# This module exposes the methods for communicating with the API endpoint /pricing.
module SevenApi::Resources
  class Pricing < SevenApi::Resource
    @endpoint = SevenApi::Endpoint::PRICING
    @http_methods = {
      :retrieve => :get,
    }

    # Retrieve pricing
    # read more: https://www.seven.io/en/docs/gateway/http-api/pricing/
    # @param params [Hash]
    # @return [Hash,String]
    def retrieve(params = {})
      request(params)
    end
  end
end