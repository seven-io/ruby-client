# frozen_string_literal: true

require 'seven_api/resource'

# This module exposes the methods for communicating with the API endpoint /balance.
module SevenApi::Resources
  class Balance < SevenApi::Resource
    @endpoint = SevenApi::Endpoint::BALANCE
    @http_methods = {
      :retrieve => :get,
    }

    # Retrieve account balance for associated API key
    # read more: https://docs.seven.io/en/rest-api/endpoints/account#balance
    # @return [Float]
    def retrieve
      request
    end
  end
end