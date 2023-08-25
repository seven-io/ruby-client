# frozen_string_literal: true

require 'spec_helper'
require 'seven_api/resources/validate_for_voice'

RSpec.describe SevenApi, 'validate_for_voice' do
  it 'returns caller id information' do
    number = '491771783130'
    callback_host = Helper::IS_HTTP ? `curl http://ipecho.net/plain` : '127.0.0.1'
    callback = "#{callback_host}/callback.php"
    stub = { success: true }

    helper = Helper.new(SevenApi::Resources::ValidateForVoice)
    body = helper.request(helper.resource.method(:retrieve), stub, { number: number, callback: callback })

    expect(body).to be_a(Hash)
    expect(body[:success]).to be_boolean
  end
end
