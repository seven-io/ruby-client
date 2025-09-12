# frozen_string_literal: true

require 'spec_helper'
require 'seven_api/client'
require 'seven_api/resource'

RSpec.describe SevenApi, 'client' do
  it 'should contain all resource modules' do
    client = SevenApi::Client.new('test_api_key')

    client.instance_variables.each do |var|
      expect(SevenApi::Resources.const_get(client.instance_variable_get(var).class.name)).to be_truthy
    end
  end

  it 'should initialize with api key only' do
    client = SevenApi::Client.new('test_api_key')
    resource = client.instance_variable_get(:@Sms)
    
    expect(resource.api_key).to eq('test_api_key')
    expect(resource.sent_with).to eq('ruby')
    expect(resource.signing_secret).to be_nil
  end

  it 'should initialize with api key and sent_with' do
    client = SevenApi::Client.new('test_api_key', 'custom-client')
    resource = client.instance_variable_get(:@Sms)
    
    expect(resource.api_key).to eq('test_api_key')
    expect(resource.sent_with).to eq('custom-client')
    expect(resource.signing_secret).to be_nil
  end

  it 'should initialize with api key, sent_with, and signing_secret' do
    client = SevenApi::Client.new('test_api_key', 'custom-client', 'secret123')
    resource = client.instance_variable_get(:@Sms)
    
    expect(resource.api_key).to eq('test_api_key')
    expect(resource.sent_with).to eq('custom-client')
    expect(resource.signing_secret).to eq('secret123')
  end
end
