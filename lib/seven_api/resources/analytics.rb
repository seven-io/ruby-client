# frozen_string_literal: true

require 'seven_api/resource'

# This module exposes the methods for communicating with the API endpoint /analytics.
module SevenApi::Resources
  class Analytics < SevenApi::Resource
    @endpoint = SevenApi::Endpoint::ANALYTICS
    PATHS = {
      :by_country => "/country",
      :by_date => "/date",
      :by_label => "/label",
      :by_subaccount => "/subaccount",
    }
    @http_methods = {
      :by_country => :get,
      :by_date => :get,
      :by_label => :get,
      :by_subaccount => :get,
    }

    # Retrieve analytics grouped by country
    # read more: https://docs.seven.io/en/rest-api/endpoints/account#statistics
    # @param params [Hash]
    # @return [Array]
    def by_country(params = {})
      request({}, params, PATHS[:by_country])
    end

    # Retrieve analytics grouped by date
    # read more: https://docs.seven.io/en/rest-api/endpoints/account#statistics
    # @param params [Hash]
    # @return [Array]
    def by_date(params = {})
      request({}, params, PATHS[:by_date])
    end

    # Retrieve analytics grouped by label
    # read more: https://docs.seven.io/en/rest-api/endpoints/account#statistics
    # @param params [Hash]
    # @return [Array]
    def by_label(params = {})
      request({}, params, PATHS[:by_label])
    end

    # Retrieve analytics grouped by subaccount
    # read more: https://docs.seven.io/en/rest-api/endpoints/account#statistics
    # @param params [Hash]
    # @return [Array]
    def by_subaccount(params = {})
      request({}, params, PATHS[:by_subaccount])
    end
  end
end
