# frozen_string_literal: true

# This module holds all utilities related to the /subaccounts endpoint.
module SevenApi::Subaccounts
  module Action
    CREATE = 'create'
    DELETE = 'delete'
    READ = 'read'
    TRANSFER_CREDITS = 'transfer_credits'
    UPDATE = 'update'
  end

  module Validator
    def self.is_action?(str)
      SevenApi::Util::in_module_constants?(str, SevenApi::Subaccounts::Action)
    end

    def self.validate(params)
      action = params[:action]

      case action
      when SevenApi::Subaccounts::Action::CREATE
        raise 'Parameter validation failed' unless SevenApi::Subaccounts::Validator::create(params)
      when SevenApi::Subaccounts::Action::DELETE
        raise 'Parameter validation failed' unless SevenApi::Subaccounts::Validator::delete(params)
      when SevenApi::Subaccounts::Action::TRANSFER_CREDITS
        raise 'Parameter validation failed' unless SevenApi::Subaccounts::Validator::transfer_credits(params)
      when SevenApi::Subaccounts::Action::UPDATE
        raise 'Parameter validation failed' unless SevenApi::Subaccounts::Validator::update(params)
      else
        raise "Unknown action #{action}" unless SevenApi::Subaccounts::Validator::is_action?(action)
      end
    end

    def self.create(params)
      SevenApi::Util::lengthy_string?(params[:email]) &&
        SevenApi::Util::lengthy_string?(params[:name])
    end

    def self.delete(params)
      SevenApi::Util::is_positive_integer?(params[:id])
    end

    def self.transfer_credits(params)
      SevenApi::Util::is_positive_integer?(params[:amount]) &&
        SevenApi::Util::is_positive_integer?(params[:id])
    end

    def self.update(params)
      SevenApi::Util::is_positive_integer?(params[:amount]) &&
        SevenApi::Util::is_positive_integer?(params[:id]) &&
        SevenApi::Util::is_positive_integer?(params[:threshold])
    end
  end
end
