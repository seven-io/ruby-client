# frozen_string_literal: true

require 'spec_helper'
require 'seven_api/client'
require 'seven_api/resource'

RSpec.describe SevenApi, 'client' do
  it 'should contain all resource modules' do
    client = SevenApi::Client.new(SevenApi::Resource.new('x'))

    client.instance_variables.each do |var|
      expect(SevenApi::Resources.const_get(client.instance_variable_get(var).class.name)).to be_truthy
    end
  end
end
