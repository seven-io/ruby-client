# frozen_string_literal: true

require 'sms77/resource'

# This module exposes the methods for communicating with the API endpoint /analytics.
module Sms77::Resources
  class Analytics < Sms77::Resource
    @endpoint = Sms77::Endpoint::ANALYTICS
    @http_methods = {
      :retrieve => :get,
    }

    # Retrieve analytics for associated API key
    # read more: https://www.sms77.io/en/docs/gateway/http-api/analytics/
    # @param params [Hash]
    # @return [Array]
    def retrieve(params = {})
      request(params)
    end
  end
end
