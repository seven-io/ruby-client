# frozen_string_literal: true

require 'sms77/client'
require 'sms77/resource'
require 'spec_helper'

RSpec.describe Sms77, 'client' do
  it 'should contain all resource modules' do
    client = Sms77::Client.new(Sms77::Resource.new('x'))

    client.instance_variables.each do |var|
      expect(Sms77::Resources.const_get(client.instance_variable_get(var).class.name)).to be_truthy
    end
  end
end
