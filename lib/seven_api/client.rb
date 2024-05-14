# frozen_string_literal: true

require 'seven_api/resources/analytics'
require 'seven_api/resources/balance'
require 'seven_api/resources/contacts'
require 'seven_api/resources/groups'
require 'seven_api/resources/hooks'
require 'seven_api/resources/journal'
require 'seven_api/resources/lookup'
require 'seven_api/resources/numbers'
require 'seven_api/resources/pricing'
require 'seven_api/resources/sms'
require 'seven_api/resources/status'
require 'seven_api/resources/subaccounts'
require 'seven_api/resources/validate_for_voice'
require 'seven_api/resources/voice'
require 'seven_api/util'

module SevenApi
  class Client
    # @param resource [SevenApi::Resource]
    def initialize(resource)
      SevenApi::Util::get_namespace_classes(SevenApi::Resources).each do |cls|
        name = cls.name.split('::').last

        instance_variable_set("@#{name}", cls.new(resource))

        singleton_class.instance_eval("attr_reader :#{name}")
      end
    end
  end
end
