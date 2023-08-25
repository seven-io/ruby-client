# frozen_string_literal: true

require 'seven_api/resource'

# This module exposes the methods for communicating with the API endpoint /contacts.
module SevenApi::Resources
  class Contacts < SevenApi::Resource
    @endpoint = SevenApi::Endpoint::CONTACTS
    @http_methods = {
      :delete => :post,
      :read => :get,
      :write => :post,
    }

    # Retrieve contacts associated with the API key
    # read more: https://www.seven.io/en/docs/gateway/http-api/contacts/#read-contacts
    # @param params [Hash]
    # @return [String, Hash]
    def read(params = {})
      request(params.merge({ :action => SevenApi::Contacts::Action::READ }))
    end

    # Delete an account with given ID
    # read more: https://www.seven.io/en/docs/gateway/http-api/contacts/#delete-contacts
    # @param params [Hash]
    # @return [String, Hash]
    def delete(params)
      request({}, params.merge({ :action => SevenApi::Contacts::Action::DEL }))
    end

    # Create or update a contact
    # read more: https://www.seven.io/en/docs/gateway/http-api/contacts/#create-and-edit-contacts
    # @param params [Hash]
    # @return [String, Hash]
    def write(params)
      request({}, params.merge({ :action => SevenApi::Contacts::Action::WRITE }))
    end
  end
end