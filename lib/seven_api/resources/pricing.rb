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
    # read more: https://docs.seven.io/en/rest-api/endpoints/account#prices
    # @param params [Hash]
    # @return [Hash,String]
    def retrieve(params = {})
      request(params)
    end
  end
end