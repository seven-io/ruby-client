# frozen_string_literal: true

require 'sms77/resource'

module Sms77::Resources
  class Journal < Sms77::Resource
    @endpoint = Sms77::Endpoint::JOURNAL
    @http_methods = {
      :retrieve => :get,
    }

    def retrieve(params)
      request(params)
    end
  end
end