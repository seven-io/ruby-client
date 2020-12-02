# frozen_string_literal: true

require 'sms77/resource'

module Sms77::Resources
  class Balance < Sms77::Resource
    @endpoint = Sms77::Endpoint::BALANCE
    @http_methods = {
      :retrieve => :get,
    }

    def retrieve
      request
    end
  end
end