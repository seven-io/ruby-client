# frozen_string_literal: true

require 'spec_helper'
require 'seven_api/resources/voice'

RSpec.describe SevenApi, 'voice' do
  def assert_response(response)
    expect(response).to be_a(String)

    code, id, cost = response.split("\n")

    expect(Integer(code)).to be_an_instance_of(Integer)
    expect(id.to_f).to be_an_instance_of(Float) if id != ''
    expect(cost.to_f).to be_an_instance_of(Float)
  end

  def request(text, extra_params = {})
    stub = <<~TEXT
      301
      
      0.1
    TEXT

    params = {
      from: nil,
      text: text,
      to: '491716992343'
    }.merge(extra_params)

    helper = Helper.new(SevenApi::Resources::Voice)
    assert_response(helper.request(helper.resource.method(:send), stub, params))
  end

  it 'calls a number with text input' do
    request('Your glasses are ready for pickup.')
  end

  it 'calls a number with xml input' do
    text = <<~XML
      <?xml version="1.0" encoding="UTF-8"?>
      <Response>
        <Say voice="woman" language="en-EN">
          Your glasses are ready for pickup.
        </Say>
        <Record maxlength="20" />
      </Response>
    XML

    request(text, { xml: true })
  end
end
