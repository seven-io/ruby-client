# frozen_string_literal: true

require 'seven_api/resource'

# This module exposes the methods for communicating with the API endpoint /numbers.
module SevenApi::Resources
  class Numbers < SevenApi::Resource
    @endpoint = SevenApi::Endpoint::NUMBERS
    @http_methods = {
      :active => :get,
      :available => :get,
      :order => :post,
      :one => :get,
      :update => :patch,
    }

    # Retrieve active phone numbers
    # read more: https://docs.seven.io/en/rest-api/endpoints/numbers#active-numbers
    # @return [Array]
    def active
      request({}, {}, '/active')
    end


    # Retrieve available phone numbers
    # read more: https://docs.seven.io/en/rest-api/endpoints/numbers#available-numbers
    # @return [Hash]
    def available
      request(params, {}, '/available')
    end

    # Order a phone number
    # read more: https://docs.seven.io/en/rest-api/endpoints/numbers#order-a-number
    # @param number [String]
    # @param payment_interval [String]
    # @return [Hash]
    def order(number, payment_interval = PaymentInterval.ASCENDING)
      payload = {
        number => number,
        payment_interval => payment_interval,
      }
      request(payload, {}, '/order')
    end

    # Delete a number
    # read more: https://docs.seven.io/en/rest-api/endpoints/numbers#delete-number
    # @param number [String]
    # @return [Hash]
    def delete(number, delete_immediately = false)
      request({}, {delete_immediately => delete_immediately}, "/active/#{number}")
    end

    # Retrieve a number
    # read more: https://docs.seven.io/en/rest-api/endpoints/numbers#get-number
    # @param number [String]
    # @return [Hash]
    def one(number)
      request({}, {}, "/active/#{number}")
    end

    # Update a number
    # read more: https://docs.seven.io/en/rest-api/endpoints/numbers#update-number
    # @param number [String]
    # @param params [Hash]
    # @return [Hash]
    def update(number, params)
      request(params, {}, "/active/#{number}")
    end
  end
end