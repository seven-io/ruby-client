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
    }

    # Perform a caller name lookup
    # read more: https://www.seven.io/en/docs/gateway/http-api/cnam-lookup/
    # @param params [Hash]
    # @return [Hash,Array]
    def cnam(params)
      request(params.merge({ :type => SevenApi::Lookup::Type::CNAM }))
    end

    # Retrieve phone number formats
    # read more: https://www.seven.io/en/docs/gateway/http-api/nummernformat-lookup/
    # @param params [Hash]
    # @return [String,Hash]
    def format(params)
      request(params.merge({ :type => SevenApi::Lookup::Type::FORMAT }))
    end

    # Perform a home location register lookup
    # read more: https://www.seven.io/en/docs/gateway/http-api/hlr-lookup/
    # @param params [Hash]
    # @return [Hash,Array]
    def hlr(params)
      request(params.merge({ :type => SevenApi::Lookup::Type::HLR }))
    end

    # Perform a mobile number portability lookup
    # read more: https://www.seven.io/en/docs/gateway/http-api/mnp-lookup/
    # @param params [Hash]
    # @return [Hash,Array]
    def mnp(params)
      request(params.merge({ :type => SevenApi::Lookup::Type::MNP }))
    end
  end
end