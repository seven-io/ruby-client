# frozen_string_literal: true

require 'seven_api/resource'

# This module exposes the methods for communicating with the API endpoint /rcs.
module SevenApi::Resources
  class Rcs < SevenApi::Resource
    @endpoint = SevenApi::Endpoint::RCS
    @http_methods = {
      :delete => :delete,
      :dispatch => :post,
      :event => :post
    }

    # Send RCS
    # read more: https://docs.seven.io/en/rest-api/endpoints/rcs#send-rcs
    # @param params [Hash]
    # @return [Hash]
    def dispatch(params)
      request(params, {}, '/messages')
    end

    # Delete scheduled RCS
    # read more: https://docs.seven.io/en/rest-api/endpoints/rcs#delete-rcs
    # @param params [Hash]
    # @return [Hash]
    def delete(params)
      request({}, {}, "/messages/#{params[:id]}")
    end

    # Send Event
    # read more: https://docs.seven.io/en/rest-api/endpoints/rcs#events
    # @param params [Hash]
    # @return [Hash]
    def event(params)
      request(params, {}, '/events')
    end
  end
end