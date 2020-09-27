# frozen_string_literal: true

require 'spec_helper'
require 'logger'

describe Sms77::Http do
  before(:all) do
  end

  after(:all) do
  end

  after(:each) do
  end

  let(:config) do
    Helper.config
  end

  let(:logger) do
    Logger.new($stderr).tap do |logger|
      logger.level = Logger::ERROR
    end
  end

  let(:instance) do
    described_class.new(config, logger)
  end

  context 'GET' do
    it 'performs GET requests' do
      Helper.maybe_stub_balance(:get)

      response = instance.get(url: 'balance')
      puts response.body

      expect(response.body.to_f).to be_kind_of(Float)
    end
  end
end
