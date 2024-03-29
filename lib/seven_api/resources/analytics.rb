# frozen_string_literal: true

require 'seven_api/resource'

# This module exposes the methods for communicating with the API endpoint /analytics.
module SevenApi::Resources
  class Analytics < SevenApi::Resource
    @endpoint = SevenApi::Endpoint::ANALYTICS
    @http_methods = {
      :retrieve => :get,
    }

    # Retrieve analytics for associated API key
    # read more: https://www.seven.io/en/docs/gateway/http-api/analytics/
    # @param params [Hash]
    # @return [Array]
    def retrieve(params = {})
      request(params)
    end
  end
end
