# frozen_string_literal: true

require 'spec_helper'
require 'sms77/endpoint'
require 'sms77/contacts'

RSpec.describe Sms77, 'sms' do
  $text = 'Your glasses are ready for pickup.'

  def assert_response(response)
    if response.is_a?(String)
      id, name, number = response.split("\n")
    else
      id = response['ID']
      name = response['Name']
      number = response['Number']
    end

    expect(Integer(id)).to be_an_instance_of(Integer)
    expect(name.to_f).to be_an_instance_of(Float) if id != ''
    expect(number.to_f).to be_an_instance_of(Float)
  end

  def request(stub, extra_params = {})
    params = {
      from: Helper.virtual_inbound_nr_eplus,
      text: $text,
      to: Helper.virtual_inbound_nr_eplus
    }.merge(extra_params)

    Helper.post(Sms77::Endpoint::SMS, stub, params)
  end

  it 'sends a single sms and returns success code' do
    expect(request(100)).to be_a(Integer)
  end

  it 'sends a single sms and returns detailed text response' do
    stub = <<~TEXT
      100
      Verbucht: 0
      Preis: 0.075
      Guthaben: 4.575
      Text: Your glasses are ready for pickup.
      SMS-Typ: direct
      Flash SMS: false
      Encoding: gsm
      GSM0338: true
      Debug: true
    TEXT

    body = request(stub, { details: 1 })

    expect(body).to be_a(String)

    code, booked, cost, balance, text, type, flash, encoding, gsm0338, debug = body.split("\n")

    expect(code).to be_a(String)
    expect(booked.split(':').last.to_f).to be_a(Float)
    expect(cost.split(':').last.to_f).to be_a(Float)
    expect(balance.split(':').last.to_f).to be_a(Float)
    expect(text.split(':').last.strip!).to eq($text)
    expect(type.split(':').last.strip!).to eq('direct')
    expect(flash.split(':').last.strip!).to eq('false')
    expect(encoding.split(':').last.strip!).to eq('gsm')
    expect(gsm0338.split(':').last.strip!).to eq('true')
    expect(debug.split(':').last.strip!).to eq('true')
  end

  it 'sends a single sms and returns json response' do
    stub = {
      success: '100',
      total_price: 0,
      balance: 4.5,
      debug: 'true',
      sms_type: 'direct',
      messages: [{ id: nil,
                   sender: '491771783130',
                   recipient: '491771783130',
                   text: 'Your glasses are ready for pickup.',
                   encoding: 'gsm',
                   parts: 1,
                   price: 0,
                   success: true,
                   error: nil,
                   error_text: nil }]
    }

    body = request(stub, { json: 1 })

    expect(body).to be_a(Hash)

    expect(body[:success]).to be_a(String)
    expect(body[:total_price]).to be_numeric
    expect(body[:balance]).to be_a(Float)
    expect(body[:debug]).to be_a(String)
    expect(body[:sms_type]).to eq('direct')
    expect(body[:messages]).to be_a(Array)
    body[:messages].each do |message|
      expect(message).to be_a(Hash)
    end
  end
end
