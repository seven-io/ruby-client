# frozen_string_literal: true

require 'sms77/resource'

# This module exposes the methods for communicating with the API endpoint /hooks.
# read more: https://www.sms77.io/en/docs/gateway/http-api/webhooks/
module Sms77::Resources
  class Hooks < Sms77::Resource
    @endpoint = Sms77::Endpoint::HOOKS
    @http_methods = {
      :read => :get,
      :subscribe => :post,
      :unsubscribe => :post,
    }

    # Retrieve all webhooks
    # @param params [Hash]
    # @return [Hash]
    def read(params = {})
      request(params.merge({ :action => Sms77::Hooks::Action::READ }))
    end

    # Register a new webhook
    # @param params [Hash]
    # @return [Hash]
    def subscribe(params)
      Sms77::Hooks::Validator::subscribe(params)

      request(params.merge({ :action => Sms77::Hooks::Action::SUBSCRIBE }))
    end

    # Delete a webhook
    # @param params [Hash]
    # @return [Hash]
    def unsubscribe(params)
      Sms77::Hooks::Validator::unsubscribe(params)

      request(params.merge({ :action => Sms77::Hooks::Action::UNSUBSCRIBE }))
    end
  end
end