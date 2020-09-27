# frozen_string_literal: true

require 'spec_helper'

describe Sms77 do
  it 'has a version number' do
    expect(Sms77::VERSION).not_to be nil
  end

  context 'failing authentication' do
    it 'balance' do
      expect { Sms77::Client.new('NotExistingApiKey', nil) }.to raise_error(RuntimeError)
    end
  end
end
