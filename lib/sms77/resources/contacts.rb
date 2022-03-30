# frozen_string_literal: true

require 'sms77/resource'

# This module exposes the methods for communicating with the API endpoint /contacts.
module Sms77::Resources
  class Contacts < Sms77::Resource
    @endpoint = Sms77::Endpoint::CONTACTS
    @http_methods = {
      :delete => :post,
      :read => :get,
      :write => :post,
    }

    # Retrieve contacts associated with the API key
    # read more: https://www.sms77.io/en/docs/gateway/http-api/contacts/#read-contacts
    # @param params [Hash]
    # @return [String, Hash]
    def read(params = {})
      request(params.merge({ :action => Sms77::Contacts::Action::READ }))
    end

    # Delete an account with given ID
    # read more: https://www.sms77.io/en/docs/gateway/http-api/contacts/#delete-contacts
    # @param params [Hash]
    # @return [String, Hash]
    def delete(params)
      request({}, params.merge({ :action => Sms77::Contacts::Action::DEL }))
    end

    # Create or update a contact
    # read more: https://www.sms77.io/en/docs/gateway/http-api/contacts/#create-and-edit-contacts
    # @param params [Hash]
    # @return [String, Hash]
    def write(params)
      request({}, params.merge({ :action => Sms77::Contacts::Action::WRITE }))
    end
  end
end