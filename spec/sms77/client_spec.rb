# frozen_string_literal: true

require 'spec_helper'
require 'sms77/endpoint'

RSpec.describe Sms77, 'client' do
  it 'checks api key' do
    expect(Helper.client.api_key).to be_lengthy_string
  end

  it 'checks sentWith' do
    expect(Helper.client.sent_with).to be_lengthy_string
  end

  it 'fails authentication' do
    expect { Sms77::Client.new('') }.to raise_error(RuntimeError)
  end
end
