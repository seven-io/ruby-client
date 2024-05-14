# frozen_string_literal: true

require 'spec_helper'
require 'seven_api/resources/balance'

RSpec.describe SevenApi, 'balance' do
  it 'returns the account balance' do
    helper = Helper.new(SevenApi::Resources::Balance)
    stub = {
      amount: 44.631,
      currency: "EUR"
    }
    balance = helper.request(helper.resource.method(:retrieve), stub)
    expect(balance).to be_a(Hash)
    expect(balance[:amount]).to be_a(Float)
    expect(balance[:currency]).to be_a(String)
  end
end
