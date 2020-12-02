# frozen_string_literal: true

require 'spec_helper'
require 'sms77/resource'

RSpec.describe Sms77, 'instance' do
  helper = Helper.new(Sms77::Resource)

  it 'checks api key' do
    expect(helper.resource.api_key).to be_lengthy_string
  end

  it 'checks sentWith' do
    expect(helper.resource.sent_with).to be_lengthy_string
  end

  it 'fails authentication' do
    expect { Sms77::Resource.new('') }.to raise_error(RuntimeError)
  end
end
