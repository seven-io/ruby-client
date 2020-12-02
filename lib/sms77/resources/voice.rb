# frozen_string_literal: true

require 'sms77/resource'

module Sms77::Resources
  class Voice < Sms77::Resource
    @endpoint = Sms77::Endpoint::VOICE
    @http_methods = {
      :send => :post,
    }

    def send(params)
      request(params)
    end
  end
end