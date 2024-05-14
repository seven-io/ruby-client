# frozen_string_literal: true

require 'spec_helper'
require 'seven_api/resources/numbers'

dummy_number = {
  "country": "DE",
  "number": "49176123456789",
  "friendly_name": "",
  "billing": {
    "fees": {
      "setup": 19.9,
      "basic_charge": 238.8,
      "sms_mo": 0,
      "voice_mo": 0
    },
    "payment_interval": "annually"
  },
  "features": {
    "sms": true,
    "a2p_sms": false,
    "voice": true
  },
  "forward_sms_mo": {
    "sms": {
      "number": [
        "4917612345678"
      ],
      "enabled": true
    },
    "email": {
      "address": %w[j.doe@acme.inc john@doe.com],
      "enabled": true
    }
  },
  "expires": nil,
  "created": "2024-01-31 17:06:27"
}

RSpec.describe SevenApi, 'numbers' do
  $new_number_id = nil

  def assert_new(response_body)
    code = response_body[:return]
    $new_number_id = response_body[:id]

    expect(code).to be_numeric
    expect($new_number_id).to be_an_instance_of(Integer)
  end

  def assert_number(number)
    expect(number[:id]).to be_numeric
    expect(number[:name]).to be_an_instance_of(String)
  end

  it 'returns available numbers' do
    stub = {
      availableNumbers: [
        dummy_number,
        dummy_number
      ],
    }

    helper = Helper.new(SevenApi::Resources::Numbers)
    body = helper.request(helper.resource.method(:available), stub)

    expect(body).to be_a(Hash)
    expect(body).to have_key(:availableNumbers)
    expect(body[:availableNumbers]).to be_a(Array)

    body[:availableNumbers].each do |number|
      assert_number(number)
    end
  end

  it 'returns active numbers' do
    stub = {
      availableNumbers: [
        dummy_number,
        dummy_number
      ],
    }

    helper = Helper.new(SevenApi::Resources::Numbers)
    body = helper.request(helper.resource.method(:active), stub)

    expect(body).to be_a(Array)

    body.each do |number|
      assert_number(number)
    end
  end

  it 'order a number' do
    stub = dummy_number
    helper = Helper.new(SevenApi::Resources::Numbers)
    body = helper.request(helper.resource.method(:order), stub)

    expect(body).to be_a(Hash)

    assert_new(body)
  end

  it 'update a number' do
    stub = dummy_number
    helper = Helper.new(SevenApi::Resources::Numbers)
    body = helper.request(helper.resource.method(:update), stub)

    expect(body).to be_a(Hash)

    assert_new(body)
  end

  it 'get a number' do
    stub = dummy_number
    helper = Helper.new(SevenApi::Resources::Numbers)
    body = helper.request(helper.resource.method(:one[:number]), stub)

    expect(body).to be_a(Hash)

    assert_new(body)
  end

  it 'deletes a number' do
    helper = Helper.new(SevenApi::Resources::Numbers)
    body = helper.request(
      helper.resource.method(:delete),
      nil,
      0
    )

    expect(body).to be_a(Hash)
    expect(body[:return]).to be_a(String)
  end
end
