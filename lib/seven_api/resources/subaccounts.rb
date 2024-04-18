# frozen_string_literal: true

require 'seven_api/resource'
require 'seven_api/subaccounts'

# This module exposes the methods for communicating with the API endpoint /subaccounts.
module SevenApi::Resources
  class Subaccounts < SevenApi::Resource
    @endpoint = SevenApi::Endpoint::SUBACCOUNTS
    @http_methods = {
      :create => :post,
      :delete => :post,
      :read => :get,
      :transfer_credits => :post,
      :update => :post,
    }

    # Create a subaccount
    # read more: https://docs.seven.io/en/rest-api/endpoints/subaccounts#create-subaccount
    # @param params [Hash]
    # @return [Hash]
    def create(params)
      SevenApi::Subaccounts::Validator::create(params)

      request(params.merge({ :action => SevenApi::Subaccounts::Action::CREATE }))
    end

    # Delete a subaccount
    # read more: https://docs.seven.io/en/rest-api/endpoints/subaccounts#delete-a-subaccount
    # @param params [Hash]
    # @return [Hash]
    def delete(params)
      SevenApi::Subaccounts::Validator::delete(params)

      request(params.merge({ :action => SevenApi::Subaccounts::Action::DELETE }))
    end

    # Retrieve all subaccounts
    # read more: https://docs.seven.io/en/rest-api/endpoints/subaccounts#list-subaccounts
    # @param params [Hash]
    # @return [Hash]
    def read(params = {})
      request({}, params.merge({ :action => SevenApi::Subaccounts::Action::READ }))
    end

    # Transfer credits to a subaccount
    # read more: https://docs.seven.io/en/rest-api/endpoints/subaccounts#manual-credit-transfer
    # @param params [Hash]
    # @return [Hash]
    def transfer_credits(params)
      SevenApi::Subaccounts::Validator::transfer_credits(params)

      request(params.merge({ :action => SevenApi::Subaccounts::Action::TRANSFER_CREDITS }))
    end

    # Update automatic charging of a subaccount
    # read more: https://docs.seven.io/en/rest-api/endpoints/subaccounts#automatic-credit-transfer
    # @param params [Hash]
    # @return [Hash]
    def update(params)
      SevenApi::Subaccounts::Validator::update(params)

      request(params.merge({ :action => SevenApi::Subaccounts::Action::UPDATE }))
    end
  end
end