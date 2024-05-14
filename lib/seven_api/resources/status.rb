# frozen_string_literal: true

require 'seven_api/resource'

# This module exposes the methods for communicating with the API endpoint /status.
module SevenApi::Resources
  class Status < SevenApi::Resource
    @endpoint = SevenApi::Endpoint::STATUS
    @http_methods = {
      :retrieve => :get,
    }

    # Retrieve delivery report for a SMS
    # read more: https://docs.seven.io/en/rest-api/endpoints/status-reports#query-status-reports
    # @param params [Hash]
    # @return [String]
    def retrieve(params)
      request(params)
    end
  end
end