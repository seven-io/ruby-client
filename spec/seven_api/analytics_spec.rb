# frozen_string_literal: true

require 'spec_helper'
require 'seven_api/resources/analytics'

RSpec.describe SevenApi, 'analytics' do
  base_stub = {
    hlr: 0,
    inbound: 72,
    mnp: 0,
    sms: 145,
    usage_eur: 0.208,
    voice: 0
  }
  helper = Helper.new(SevenApi::Resources::Analytics)

  it 'returns an array with analytics grouped by country' do
    stub = [base_stub.merge({country: "DE"})]
    entries = helper.request(helper.resource.method(:by_country), stub)
    expect(entries).to be_a(Array)
  end

  it 'returns an array with analytics grouped by date' do
    stub = [base_stub.merge({date: "2020-05-13"})]
    entries = helper.request(helper.resource.method(:by_date), stub)
    expect(entries).to be_a(Array)
  end

  it 'returns an array with analytics grouped by label' do
    stub = [base_stub.merge({label: "Label"})]
    entries = helper.request(helper.resource.method(:by_label), stub)
    expect(entries).to be_a(Array)
  end

  it 'returns an array with analytics grouped by subaccount' do
    stub = [base_stub.merge({account: "Subaccount"})]
    entries = helper.request(helper.resource.method(:by_subaccount), stub)
    expect(entries).to be_a(Array)
  end
end
