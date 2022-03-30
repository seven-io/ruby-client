# frozen_string_literal: true

require 'sms77/resource'

# This module exposes the methods for communicating with the API endpoint /journal.
module Sms77::Resources
  class Journal < Sms77::Resource
    @endpoint = Sms77::Endpoint::JOURNAL
    @http_methods = {
      :retrieve => :get,
    }

    # Retrieve the journal for associated API key
    # read more: https://www.sms77.io/en/docs/gateway/http-api/journal/
    # @param params [Hash]
    # @return [Array]
    def retrieve(params)
      request(params)
    end
  end
end