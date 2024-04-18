# frozen_string_literal: true

require 'seven_api/resource'

# This module exposes the methods for communicating with the API endpoint /analytics.
module SevenApi::Resources
  class Analytics < SevenApi::Resource
    @endpoint = SevenApi::Endpoint::ANALYTICS
    @http_methods = {
      :retrieve => :get,
    }

    # Retrieve analytics grouped by date
    # read more: https://docs.seven.io/en/rest-api/endpoints/account#statistics
    # @param params [Hash]
    # @return [Array]
    def by_date(params = {})
      retrieve('date', params)
    end

    # Retrieve analytics grouped by country
    # read more: https://docs.seven.io/en/rest-api/endpoints/account#statistics
    # @param params [Hash]
    # @return [Array]
    def by_country(params = {})
      retrieve('country', params)
    end

    # Retrieve analytics grouped by label
    # read more: https://docs.seven.io/en/rest-api/endpoints/account#statistics
    # @param params [Hash]
    # @return [Array]
    def by_label(params = {})
      retrieve('label', params)
    end

    # Retrieve analytics grouped by subaccount
    # read more: https://docs.seven.io/en/rest-api/endpoints/account#statistics
    # @param params [Hash]
    # @return [Array]
    def by_subaccount(params = {})
      retrieve('subaccount', params)
    end

    private

    # Retrieve analytics for associated API key
    # read more: https://docs.seven.io/en/rest-api/endpoints/account#statistics
    # @param params [Hash]
    # @return [Array]
    def retrieve(group_by, params = {})
      request(params.merge({group_by: group_by}))
    end
  end
end
