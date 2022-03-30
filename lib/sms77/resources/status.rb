# frozen_string_literal: true

require 'sms77/resource'

# This module exposes the methods for communicating with the API endpoint /status.
module Sms77::Resources
  class Status < Sms77::Resource
    @endpoint = Sms77::Endpoint::STATUS
    @http_methods = {
      :retrieve => :get,
    }

    # Retrieve delivery report for a SMS
    # read more: https://www.sms77.io/en/docs/gateway/http-api/status-reports/#query-delivery-reports
    # @param params [Hash]
    # @return [String]
    def retrieve(params)
      request(params)
    end
  end
end