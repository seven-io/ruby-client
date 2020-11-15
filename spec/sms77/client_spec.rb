# frozen_string_literal: true

require 'spec_helper'
require 'sms77/endpoint'

RSpec.describe Sms77, 'client' do
  it 'checks api key' do
    expect(Helper.client.api_key).to be_lengthy(String)
  end

  it 'checks sentWith' do
    expect(Helper.client.sent_with).to be_lengthy(String)
  end
end
