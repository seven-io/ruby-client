# frozen_string_literal: true

require 'sms77/resource'
require 'sms77/subaccounts'

module Sms77::Resources
  class Subaccounts < Sms77::Resource
    @endpoint = Sms77::Endpoint::SUBACCOUNTS
    @http_methods = {
      :create => :post,
      :delete => :post,
      :read => :get,
      :transfer_credits => :post,
      :update => :post,
    }

    def create(params)
      Sms77::Subaccounts::Validator::create(params)

      request(params.merge({ :action => Sms77::Subaccounts::Action::CREATE }))
    end

    def delete(params)
      Sms77::Subaccounts::Validator::delete(params)

      request(params.merge({ :action => Sms77::Subaccounts::Action::DELETE }))
    end

    def read(params = {})
      request({}, params.merge({ :action => Sms77::Subaccounts::Action::READ }))
    end

    def transfer_credits(params)
      Sms77::Subaccounts::Validator::transfer_credits(params)

      request(params.merge({ :action => Sms77::Subaccounts::Action::TRANSFER_CREDITS }))
    end

    def update(params)
      Sms77::Subaccounts::Validator::update(params)

      request(params.merge({ :action => Sms77::Subaccounts::Action::UPDATE }))
    end
  end
end