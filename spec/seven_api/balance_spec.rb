# frozen_string_literal: true

require 'spec_helper'
require 'seven_api/resources/balance'

RSpec.describe SevenApi, 'balance' do
  it 'returns the account balance' do
    helper = Helper.new(SevenApi::Resources::Balance)
    balance = helper.request(helper.resource.method(:retrieve), 155.55)
    expect(balance).to be_a(Float)
  end
end
