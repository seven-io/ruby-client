# frozen_string_literal: true

require 'sms77/resource'
require 'sms77/subaccounts'

# This module exposes the methods for communicating with the API endpoint /subaccounts.
module Sms77::Resources
  class Subaccounts < Sms77::Resource
    @endpoint = Sms77::Endpoint::SUBACCOUNTS
    @http_methods = {
      :create => :post,
      :delete => :post,
      :read => :get,
      :transfer_credits => :post,
      :update => :post,
    }

    # Create a subaccount
    # read more: https://www.sms77.io/en/docs/gateway/http-api/subaccounts/#create-subaccount
    # @param params [Hash]
    # @return [Hash]
    def create(params)
      Sms77::Subaccounts::Validator::create(params)

      request(params.merge({ :action => Sms77::Subaccounts::Action::CREATE }))
    end

    # Delete a subaccount
    # read more: https://www.sms77.io/en/docs/gateway/http-api/subaccounts/#delete-subaccount
    # @param params [Hash]
    # @return [Hash]
    def delete(params)
      Sms77::Subaccounts::Validator::delete(params)

      request(params.merge({ :action => Sms77::Subaccounts::Action::DELETE }))
    end

    # Retrieve all subaccounts
    # read more: https://www.sms77.io/en/docs/gateway/http-api/subaccounts/#read-subaccounts
    # @param params [Hash]
    # @return [Hash]
    def read(params = {})
      request({}, params.merge({ :action => Sms77::Subaccounts::Action::READ }))
    end

    # Transfer credits to a subaccount
    # read more: https://www.sms77.io/en/docs/gateway/http-api/subaccounts/#transfer-credit
    # @param params [Hash]
    # @return [Hash]
    def transfer_credits(params)
      Sms77::Subaccounts::Validator::transfer_credits(params)

      request(params.merge({ :action => Sms77::Subaccounts::Action::TRANSFER_CREDITS }))
    end

    # Update automatic charging of a subaccount
    # read more: https://www.sms77.io/en/docs/gateway/http-api/subaccounts/#update-automatic-charging-of-the-subaccount
    # @param params [Hash]
    # @return [Hash]
    def update(params)
      Sms77::Subaccounts::Validator::update(params)

      request(params.merge({ :action => Sms77::Subaccounts::Action::UPDATE }))
    end
  end
end