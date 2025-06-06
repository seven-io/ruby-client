# frozen_string_literal: true

require 'seven_api/resource'

# This module exposes the methods for communicating with the API endpoint /lookup.
module SevenApi::Resources
  class Lookup < SevenApi::Resource
    @endpoint = SevenApi::Endpoint::LOOKUP
    @http_methods = {
      :cnam => :get,
      :format => :get,
      :hlr => :get,
      :mnp => :get,
      :rcs_capabilities => :get
    }
    PATHS = {
      :cnam => '/cnam',
      :format => '/format',
      :hlr => '/hlr',
      :mnp => '/mnp',
      :rcs_capabilities => '/rcs'
    }

    # Perform a caller name lookup
    # read more: https://docs.seven.io/en/rest-api/endpoints/lookup#cnam
    # @param number [String]
    # @return [Hash,Array]
    def cnam(number)
      request({}, {number: number}, PATHS[:cnam])
    end

    # Retrieve phone number formats
    # read more: https://docs.seven.io/en/rest-api/endpoints/lookup#format
    # @param number [String]
    # @return [String,Hash]
    def format(number)
      request({}, {number: number}, PATHS[:format])
    end

    # Perform a home location register lookup
    # read more: https://docs.seven.io/en/rest-api/endpoints/lookup#hlr
    # @param number [String]
    # @return [Hash,Array]
    def hlr(number)
      request({}, {number: number}, PATHS[:hlr])
    end

    # Perform a mobile number portability lookup
    # read more: https://docs.seven.io/en/rest-api/endpoints/lookup#mnp
    # @param number [String]
    # @return [Hash,Array]
    def mnp(number)
      request({}, {number: number}, PATHS[:mnp])
    end

    # Perform a RCS capabilities lookup
    # read more: https://docs.seven.io/en/rest-api/endpoints/lookup#rcs-capabilities
    # @param number [String]
    # @return [Hash,Array]
    def rcs_capabilities(number)
      request({}, {number: number}, PATHS[:rcs])
    end
  end
end