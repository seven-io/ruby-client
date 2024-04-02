# frozen_string_literal: true

require 'seven_api/resource'

# This module exposes the methods for communicating with the API endpoint /contacts.
module SevenApi::Resources
  class Contacts < SevenApi::Resource
    @endpoint = SevenApi::Endpoint::CONTACTS
    @http_methods = {
      :all => :get,
      :create => :post,
      :delete => :post,
      :one => :get,
      :update => :patch,
    }

    # Retrieve contacts associated with the API key
    # read more: https://docs.seven.io/en/rest-api/endpoints/contacts#query-contact-list
    # @param params [Hash]
    # @return [Hash]
    def all(params = {})
      request(params)
    end

    # Retrieve a contact associated with the API key
    # read more: https://docs.seven.io/en/rest-api/endpoints/contacts#retrieve-contact
    # @param id [Int]
    # @return [Hash]
    def one(id)
      request({}, {}, "/#{id}")
    end

    # Delete a contact with given ID
    # read more: https://www.seven.io/en/docs/gateway/http-api/contacts/#delete-contacts
    # @param id [Integer]
    # @return [Hash]
    def delete(id)
      request({}, {}, "/#{id}")
    end

    # Create a contact
    # read more: https://docs.seven.io/en/rest-api/endpoints/contacts#create-contact
    # @param params [Hash]
    # @return [Hash]
    def create(params)
      request( params)
    end

    # Update a contact
    # read more: https://docs.seven.io/en/rest-api/endpoints/contacts#update-contact
    # @param contact [Hash]
    # @return [Hash]
    def update(contact)
      request(contact, {}, "/#{contact['id']}")
    end
  end
end