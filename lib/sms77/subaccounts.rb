# frozen_string_literal: true

module Sms77::Subaccounts
  module Action
    CREATE = 'create'
    DELETE = 'delete'
    READ = 'read'
    TRANSFER_CREDITS = 'transfer_credits'
    UPDATE = 'update'
  end

  module Validator
    def self.is_action?(str)
      Sms77::Util::in_module_constants?(str, Sms77::Subaccounts::Action)
    end

    def self.validate(params)
      action = params[:action]

      case action
      when Sms77::Subaccounts::Action::CREATE
        raise 'Parameter validation failed' unless Sms77::Subaccounts::Validator::create(params)
      when Sms77::Subaccounts::Action::DELETE
        raise 'Parameter validation failed' unless Sms77::Subaccounts::Validator::delete(params)
      when Sms77::Subaccounts::Action::TRANSFER_CREDITS
        raise 'Parameter validation failed' unless Sms77::Subaccounts::Validator::transfer_credits(params)
      when Sms77::Subaccounts::Action::UPDATE
        raise 'Parameter validation failed' unless Sms77::Subaccounts::Validator::update(params)
      else
        raise "Unknown action #{action}" unless Sms77::Subaccounts::Validator::is_action?(action)
      end
    end

    def self.create(params)
      Sms77::Util::lengthy_string?(params[:email]) &&
        Sms77::Util::lengthy_string?(params[:name])
    end

    def self.delete(params)
      Sms77::Util::is_positive_integer?(params[:id])
    end

    def self.transfer_credits(params)
      Sms77::Util::is_positive_integer?(params[:amount]) &&
        Sms77::Util::is_positive_integer?(params[:id])
    end

    def self.update(params)
      Sms77::Util::is_positive_integer?(params[:amount]) &&
        Sms77::Util::is_positive_integer?(params[:id]) &&
        Sms77::Util::is_positive_integer?(params[:threshold])
    end
  end
end
