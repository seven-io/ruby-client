# frozen_string_literal: true

require 'spec_helper'
require 'sms77/endpoint'

RSpec.describe Sms77, 'balance' do
  it 'returns the account balance' do
    Helper.stubs.get("/api/#{Sms77::Endpoint::BALANCE}") { |_env| [200, {}, '12.34'] } unless Helper.is_http

    response = Helper.client.balance

    expect(response.class).to eq(Faraday::Response)
    expect(response.body.to_f).to be_kind_of(Float)
  end
end
