# frozen_string_literal: true

require 'seven_api/resource'

# This module exposes the methods for communicating with the API endpoint /groups.
module SevenApi::Resources
  class Groups < SevenApi::Resource
    @endpoint = SevenApi::Endpoint::GROUPS
    @http_methods = {
      :all => :get,
      :create => :post,
      :delete => :delete,
      :one => :get,
      :update => :patch,
    }

    # Retrieve contacts associated with the API key
    # read more: https://docs.seven.io/en/rest-api/endpoints/groups#list-all-groups
    # @param params [Hash]
    # @return [Hash]
    def all(params = {})
      request(params)
    end

    # Retrieve a contact associated with the API key
    # read more: https://docs.seven.io/en/rest-api/endpoints/groups#retrieve-a-group
    # @param id [Int]
    # @return [Hash]
    def one(id)
      request({}, {}, "/#{id}")
    end

    # Delete a contact with given ID
    # read more: https://docs.seven.io/en/rest-api/endpoints/groups#delete-group
    # @param id [Integer]
    # @return [Hash]
    def delete(id)
      request({}, {}, "/#{id}")
    end

    # Create a contact
    # read more: https://docs.seven.io/en/rest-api/endpoints/groups#create-group
    # @param params [Hash]
    # @return [Hash]
    def create(params)
      request( params)
    end

    # Update a contact
    # read more: https://docs.seven.io/en/rest-api/endpoints/groups#update-a-group
    # @param contact [Hash]
    # @return [Hash]
    def update(contact)
      request(contact, {}, "/#{contact['id']}")
    end
  end
end