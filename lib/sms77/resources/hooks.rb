# frozen_string_literal: true

require 'sms77/resource'

module Sms77::Resources
  class Hooks < Sms77::Resource
    @endpoint = Sms77::Endpoint::HOOKS
    @http_methods = {
      :read => :get,
      :subscribe => :post,
      :unsubscribe => :post,
    }

    def read(params = {})
      request(params.merge({ :action => Sms77::Hooks::Action::READ }))
    end

    def subscribe(params)
      Sms77::Hooks::Validator::subscribe(params)

      request(params.merge({ :action => Sms77::Hooks::Action::SUBSCRIBE }))
    end

    def unsubscribe(params)
      Sms77::Hooks::Validator::unsubscribe(params)

      request(params.merge({ :action => Sms77::Hooks::Action::UNSUBSCRIBE }))
    end
  end
end