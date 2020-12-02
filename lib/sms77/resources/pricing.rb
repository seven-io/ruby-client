# frozen_string_literal: true

require 'sms77/resource'

module Sms77::Resources
  class Pricing < Sms77::Resource
    @endpoint = Sms77::Endpoint::PRICING
    @http_methods = {
      :retrieve => :get,
    }

    def retrieve(params = {})
      request(params)
    end
  end
end