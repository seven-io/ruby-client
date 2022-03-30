# frozen_string_literal: true

require 'sms77/resource'

# This module exposes the methods for communicating with the API endpoint /lookup.
module Sms77::Resources
  class Lookup < Sms77::Resource
    @endpoint = Sms77::Endpoint::LOOKUP
    @http_methods = {
      :cnam => :post,
      :format => :post,
      :hlr => :post,
      :mnp => :post,
    }

    # Perform a caller name lookup
    # read more: https://www.sms77.io/en/docs/gateway/http-api/cnam-lookup/
    # @param params [Hash]
    # @return [Hash,Array]
    def cnam(params)
      request(params.merge({ :type => Sms77::Lookup::Type::CNAM }))
    end

    # Retrieve phone number formats
    # read more: https://www.sms77.io/en/docs/gateway/http-api/nummernformat-lookup/
    # @param params [Hash]
    # @return [String,Hash]
    def format(params)
      request(params.merge({ :type => Sms77::Lookup::Type::FORMAT }))
    end

    # Perform a home location register lookup
    # read more: https://www.sms77.io/en/docs/gateway/http-api/hlr-lookup/
    # @param params [Hash]
    # @return [Hash,Array]
    def hlr(params)
      request(params.merge({ :type => Sms77::Lookup::Type::HLR }))
    end

    # Perform a mobile number portability lookup
    # read more: https://www.sms77.io/en/docs/gateway/http-api/mnp-lookup/
    # @param params [Hash]
    # @return [Hash,Array]
    def mnp(params)
      request(params.merge({ :type => Sms77::Lookup::Type::MNP }))
    end
  end
end