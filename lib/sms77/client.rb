# frozen_string_literal: true

require 'sms77/resources/analytics'
require 'sms77/resources/balance'
require 'sms77/resources/contacts'
require 'sms77/resources/hooks'
require 'sms77/resources/journal'
require 'sms77/resources/lookup'
require 'sms77/resources/pricing'
require 'sms77/resources/sms'
require 'sms77/resources/status'
require 'sms77/resources/validate_for_voice'
require 'sms77/resources/voice'
require 'sms77/util'

module Sms77
  class Client
    # @param resource [Sms77::Resource]
    def initialize(resource)
      Sms77::Util::get_namespace_classes(Sms77::Resources).each do |cls|
        name = cls.name.split('::').last

        instance_variable_set("@#{name}", cls.new(resource))

        singleton_class.instance_eval("attr_reader :#{name}")
      end
    end
  end
end
