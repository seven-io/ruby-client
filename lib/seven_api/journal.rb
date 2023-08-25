# frozen_string_literal: true

# This module holds all utilities related to the /journal endpoint.
module SevenApi::Journal
  module Type
    INBOUND = 'inbound'
    OUTBOUND = 'outbound'
    REPLIES = 'replies'
    VOICE = 'voice'
  end

  module Validator
    def self.validate(params)
      type = params[:type]
      date_from = params[:date_from]
      date_to = params[:date_to]

      raise "Unknown type #{type}" unless SevenApi::Journal::Validator::is_type?(type)
      raise "Wrong date_from #{date_from}" unless SevenApi::Journal::Validator::is_date?(date_from)
      raise "Wrong date_to #{date_to}" unless SevenApi::Journal::Validator::is_date?(date_to)
    end

    def self.subscribe(params)
      { :request_method => SevenApi::Hooks::RequestMethod::POST }.merge!(params)

      self.event_type?(params[:event_type]) &&
        self.request_method?(params[:request_method]) &&
        self.target_url?(params[:target_url])
    end

    def self.is_type?(str)
      SevenApi::Util::in_module_constants?(str, SevenApi::Journal::Type)
    end

    def self.is_date?(date)
      date.is_a?(NilClass) || date.match(/[\d]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][\d]|3[0-1])/)
    end
  end
end
