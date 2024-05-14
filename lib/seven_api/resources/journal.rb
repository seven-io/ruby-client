# frozen_string_literal: true

require 'seven_api/resource'

# This module exposes the methods for communicating with the API endpoint /journal.
module SevenApi::Resources
  class Journal < SevenApi::Resource
    @endpoint = SevenApi::Endpoint::JOURNAL
    @http_methods = {
      :retrieve => :get,
    }

    # Retrieve the journal for associated API key
    # read more: https://docs.seven.io/en/rest-api/endpoints/logbook
    # @param params [Hash]
    # @return [Array]
    def retrieve(params)
      request(params)
    end
  end
end