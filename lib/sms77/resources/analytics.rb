# frozen_string_literal: true

require 'sms77/resource'

module Sms77::Resources
  class Analytics < Sms77::Resource
    @endpoint = Sms77::Endpoint::ANALYTICS
    @http_methods = {
      :retrieve => :get,
    }

    def retrieve(params = {})
      request(params)
    end
  end
end
