# frozen_string_literal: true

require 'seven_api/resource'

# This module exposes the methods for communicating with the API endpoint /hooks.
# read more: https://docs.seven.io/en/rest-api/endpoints/webhooks
module SevenApi::Resources
  class Hooks < SevenApi::Resource
    @endpoint = SevenApi::Endpoint::HOOKS
    @http_methods = {
      :read => :get,
      :subscribe => :post,
      :unsubscribe => :post,
    }

    # Retrieve all webhooks
    # @param params [Hash]
    # @return [Hash]
    def read(params = {})
      request(params.merge({ :action => SevenApi::Hooks::Action::READ }))
    end

    # Register a new webhook
    # @param params [Hash]
    # @return [Hash]
    def subscribe(params)
      SevenApi::Hooks::Validator::subscribe(params)

      request(params.merge({ :action => SevenApi::Hooks::Action::SUBSCRIBE }))
    end

    # Delete a webhook
    # @param params [Hash]
    # @return [Hash]
    def unsubscribe(params)
      SevenApi::Hooks::Validator::unsubscribe(params)

      request(params.merge({ :action => SevenApi::Hooks::Action::UNSUBSCRIBE }))
    end
  end
end