# frozen_string_literal: true

require 'spec_helper'
require 'sms77/resources/balance'

RSpec.describe Sms77, 'balance' do
  it 'returns the account balance' do
    helper = Helper.new(Sms77::Resources::Balance)
    balance = helper.request(helper.resource.method(:retrieve), 155.55)
    expect(balance).to be_a(Float)
  end
end
