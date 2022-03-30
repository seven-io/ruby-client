# frozen_string_literal: true

require 'sms77/resource'

# This module exposes the methods for communicating with the API endpoint /balance.
module Sms77::Resources
  class Balance < Sms77::Resource
    @endpoint = Sms77::Endpoint::BALANCE
    @http_methods = {
      :retrieve => :get,
    }

    # Retrieve account balance for associated API key
    # read more: https://www.sms77.io/en/docs/gateway/http-api/credit-balance/
    # @return [Float]
    def retrieve
      request
    end
  end
end