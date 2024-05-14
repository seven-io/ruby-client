# frozen_string_literal: true

require 'spec_helper'
require 'seven_api/resources/analytics'

RSpec.describe SevenApi, 'analytics' do
  base_stub = {
    hlr: 0,
    inbound: 72,
    mnp: 0,
    rcs: 1,
    sms: 145,
    usage_eur: 0.208,
    voice: 0
  }
  helper = Helper.new(SevenApi::Resources::Analytics)

  it 'returns an array with analytics grouped by country' do
    stub = [base_stub.merge({ country: "DE" })]
    params = { country: "DE" }
    fn = helper.resource.method(:by_country)
    path = SevenApi::Resources::Analytics.const_get('PATHS')[:by_country]
    entries = helper.request(fn, stub, params, path)
    expect(entries).to be_a(Array)
  end

  it 'returns an array with analytics grouped by date' do
    stub = [base_stub.merge({ date: "2020-05-13" })]
    fn = helper.resource.method(:by_date)
    path = SevenApi::Resources::Analytics.const_get('PATHS')[:by_date]
    entries = helper.request(fn, stub, nil, path)
    expect(entries).to be_a(Array)
  end

  it 'returns an array with analytics grouped by label' do
    stub = [base_stub.merge({ label: "Label" })]
    fn = helper.resource.method(:by_label)
    path = SevenApi::Resources::Analytics.const_get('PATHS')[:by_label]
    entries = helper.request(fn, stub, nil, path)
    expect(entries).to be_a(Array)
  end

  it 'returns an array with analytics grouped by subaccount' do
    stub = [base_stub.merge({ account: "Subaccount" })]
    path = SevenApi::Resources::Analytics.const_get('PATHS')[:by_subaccount]
    entries = helper.request(helper.resource.method(:by_subaccount), stub, nil, path)
    expect(entries).to be_a(Array)
  end
end
