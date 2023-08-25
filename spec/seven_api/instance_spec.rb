# frozen_string_literal: true

#noinspection RubyResolve
require 'spec_helper'
require 'seven_api/resource'

#noinspection RubyResolve
RSpec.describe SevenApi, 'instance' do
  helper = Helper.new(SevenApi::Resource)

  it 'checks api key' do
    expect(helper.resource.api_key).to be_lengthy_string
  end

  it 'checks sentWith' do
    expect(helper.resource.sent_with).to be_lengthy_string
  end

  it 'fails authentication' do
    expect { SevenApi::Resource.new('') }.to raise_error(RuntimeError)
  end
end
