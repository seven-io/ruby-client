# frozen_string_literal: true

require 'sms77/resource'

module Sms77::Resources
  class Contacts < Sms77::Resource
    @endpoint = Sms77::Endpoint::CONTACTS
    @http_methods = {
      :delete => :post,
      :read => :get,
      :write => :post,
    }

    def read(params = {})
      request(params.merge({ :action => Sms77::Contacts::Action::READ }))
    end

    def delete(params)
      request({}, params.merge({ :action => Sms77::Contacts::Action::DEL }))
    end

    def write(params)
      request({}, params.merge({ :action => Sms77::Contacts::Action::WRITE }))
    end
  end
end