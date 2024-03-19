# frozen_string_literal: true

require 'spec_helper'
require 'seven_api/resources/rcs'

RSpec.describe SevenApi, 'rcs' do
  $helper = Helper.new(SevenApi::Resources::Rcs)

  def dispatch(stub, extra_params = {})
    params = {
      text: 'Your glasses are ready for pickup.',
      to: Helper::VIRTUAL_INBOUNDS[:eplus]
    }.merge(extra_params)

    $helper.request($helper.resource.method(:dispatch), stub, params, '/messages')
  end

  it 'sends a single rcs and returns json response' do
    stub = {
      success: '100',
      total_price: 0,
      balance: 4.52,
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
                   error_text: nil,
                   channel: 'RCS'}]
    }

    body = dispatch(stub)

    expect(body).to be_a(Hash)

    expect(body[:success]).to be_a(String)
    expect(body[:total_price]).to be_numeric
    expect(body[:balance]).to be_a(Float)
    expect(body[:debug]).to be_a(String)
    expect(body[:sms_type]).to eq('direct')
    expect(body[:messages]).to be_a(Array)
    body[:messages].each do |message|
      expect(message).to be_a(Hash)
      expect(message[:channel]).to eq('RCS')
    end
  end

  it 'schedules a rcs message and deletes it again' do
    rcs = dispatch({
                     success: '100',
                     total_price: 0,
                     balance: 4.52,
                     debug: 'true',
                     sms_type: 'direct',
                     messages: [{ id: 12345,
                                  sender: '491771783130',
                                  recipient: '491771783130',
                                  text: 'Your glasses are ready for pickup.',
                                  encoding: 'gsm',
                                  parts: 1,
                                  price: 0,
                                  success: true,
                                  error: nil,
                                  error_text: nil,
                                  channel: 'RCS'}]
                   })
    msg = rcs[:messages].first
    id = msg[:id]
    stub = {
      success: true
    }
    params = {
      id: id
    }

    deleted = $helper.request($helper.resource.method(:delete), stub, params, "/messages/#{id}")
    expect(deleted[:success]).to eq(true)
  end

  it 'triggers a rcs event' do
    stub = {
      success: true
    }
    params = {
      event: 'IS_TYPING',
      msg_id: '',
      to: '4915237035388'
    }

    event = $helper.request($helper.resource.method(:event), stub, params, '/events')
    expect(event[:success]).to eq(true)
  end
end
