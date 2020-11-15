# frozen_string_literal: true

require 'spec_helper'
require 'sms77/endpoint'

RSpec.describe Sms77, 'balance' do
  it 'returns the account balance' do
    expect(Helper.get(Sms77::Endpoint::BALANCE, 12.34)).to be_kind_of(Float)
  end
end
