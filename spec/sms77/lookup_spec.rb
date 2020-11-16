# frozen_string_literal: true

require 'spec_helper'
require 'sms77/endpoint'
require 'sms77/lookup_type'
require 'json'

RSpec.describe Sms77, 'lookup' do
  def request(type, stub, extra_args = {})
    Helper.post(Sms77::Endpoint::LOOKUP, stub, { type: type, number: '+491771783130' }.merge(extra_args))
  end

  it 'misses number to lookup' do
    stub = {
      carrier: nil,
      country_code: false,
      country_iso: nil,
      country_name: nil,
      international: '+',
      international_formatted: '',
      national: '',
      network_type: nil,
      success: false
    }

    res = request(Sms77::LookupType::FORMAT, stub, { number: '' })

    expect(res).to be_kind_of(Hash)
    expect(res[:success]).to match(false)
  end

  it 'returns number formatting details as json' do
    stub = {
      carrier: 'Eplus',
      country_code: '49',
      country_iso: 'DE',
      country_name: 'Germany',
      international: '+491771783130',
      international_formatted: '+49 177 1783130',
      national: '0177 1783130',
      network_type: 'mobile',
      success: true
    }

    body = request(Sms77::LookupType::FORMAT, stub)

    expect(body).to be_kind_of(Hash)
    expect(body[:carrier]).to be_kind_of(String)
    expect(body[:country_code]).to be_kind_of(String)
    expect(body[:country_iso]).to be_kind_of(String)
    expect(body[:country_name]).to be_kind_of(String)
    expect(body[:international]).to be_kind_of(String)
    expect(body[:international_formatted]).to be_kind_of(String)
    expect(body[:national]).to be_kind_of(String)
    expect(body[:network_type]).to be_kind_of(String)
    expect(body[:success]).to be_boolean
  end

  it 'returns CNAM details as json' do
    stub = {
      code: '100',
      name: 'GERMANY',
      number: '+491771783130',
      success: 'true'
    }
    body = request(Sms77::LookupType::CNAM, stub)

    expect(body).to be_kind_of(Hash)
    expect(body[:code]).to be_kind_of(String)
    expect(body[:name]).to be_kind_of(String)
    expect(body[:number]).to be_kind_of(String)
    expect(body[:success]).to be_kind_of(String)
  end

  it 'returns MNP details as text' do
    body = request(Sms77::LookupType::MNP, 'eplus')

    expect(body).to be_kind_of(String)
  end

  it 'returns MNP details as json' do
    stub = {
      code: 100,
      mnp: {
        country: 'DE',
        international_formatted: '+49 177 1783130',
        isPorted: false,
        mccmnc: '26203',
        national_format: '0177 1783130',
        network: "Telef\u00f3nica Germany GmbH & Co. oHG (O2)",
        number: '+491771783130'
      },
      price: 0.005,
      success: true
    }
    body = request(Sms77::LookupType::MNP, stub, { json: 1 })

    expect(body).to be_kind_of(Hash)
    expect(body[:code]).to be_kind_of(Integer)
    expect(body[:price]).to be_kind_of(Float)
    expect(body[:mnp]).to be_kind_of(Hash)
    expect(body[:mnp][:country]).to be_kind_of(String)
    expect(body[:mnp][:international_formatted]).to be_kind_of(String)
    expect(body[:mnp][:isPorted]).to be_boolean
    expect(body[:mnp][:mccmnc]).to be_kind_of(String)
    expect(body[:mnp][:national_format]).to be_kind_of(String)
    expect(body[:mnp][:network]).to be_kind_of(String)
    expect(body[:mnp][:number]).to be_kind_of(String)
    expect(body[:success]).to be_boolean
  end

  it 'returns HLR details as json' do
    stub = {
      country_code: 'DE',
      country_name: 'Germany',
      country_prefix: '49',
      current_carrier: {
        country: 'DE',
        name: "Telef\u00f3nica Germany GmbH & Co. oHG (O2)",
        network_code: '26203',
        network_type: 'mobile'
      },
      international_format_number: '491771783130',
      international_formatted: '+49 177 1783130',
      lookup_outcome: true,
      lookup_outcome_message: 'success',
      national_format_number: '0177 1783130',
      original_carrier: {
        country: 'DE',
        name: "Telef\u00f3nica Germany GmbH & Co. oHG (O2)",
        network_code: '26203',
        network_type: 'mobile'
      },
      status: true,
      status_message: 'success',
      gsm_code: '0',
      gsm_message: 'No error',
      ported: 'assumed_not_ported',
      reachable: 'reachable',
      roaming: 'not_roaming',
      valid_number: 'valid'
    }

    body = request(Sms77::LookupType::HLR, stub)

    expect(body).to be_kind_of(Hash)
    expect(body[:country_code]).to be_kind_of(String)
    expect(body[:country_name]).to be_kind_of(String)
    expect(body[:country_prefix]).to be_kind_of(String)
    assert_carrier(body[:current_carrier])
    expect(body[:international_format_number]).to be_kind_of(String)
    expect(body[:international_formatted]).to be_kind_of(String)
    expect(body[:lookup_outcome]).to be_boolean
    expect(body[:lookup_outcome_message]).to be_kind_of(String)
    expect(body[:national_format_number]).to be_kind_of(String)
    assert_carrier(body[:original_carrier])
    expect(body[:status]).to be_boolean
    expect(body[:status_message]).to be_kind_of(String)
    expect(body[:gsm_code]).to be_kind_of(String)
    expect(body[:gsm_message]).to be_kind_of(String)
    expect(body[:ported]).to be_kind_of(String)
    expect(body[:reachable]).to be_kind_of(String)
    expect(body[:roaming]).to be_kind_of(String)
    expect(body[:valid_number]).to be_kind_of(String)
  end

  def assert_carrier(hash)
    expect(hash).to be_a(Hash)
    expect(hash[:country]).to be_a(String)
    expect(hash[:name]).to be_a(String)
    expect(hash[:network_code]).to be_a(String)
    expect(hash[:network_type]).to be_a(String)
  end
end
