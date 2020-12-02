# frozen_string_literal: true

require 'sms77/resource'

module Sms77::Resources
  class Sms < Sms77::Resource
    @endpoint = Sms77::Endpoint::SMS
    @http_methods = {
      :retrieve => :post,
    }

    def retrieve(params)
      request(params)
    end
  end
end