# frozen_string_literal: true

require 'spec_helper'
require 'seven_api/resources/sms'

RSpec.describe SevenApi::Resource, 'HMAC signing' do
  let(:api_key) { 'test_api_key' }
  let(:signing_secret) { 'test_signing_secret' }
  let(:resource_with_hmac) { SevenApi::Resources::Sms.new(api_key, 'ruby-test', signing_secret) }
  let(:resource_without_hmac) { SevenApi::Resources::Sms.new(api_key, 'ruby-test') }

  describe 'initialization' do
    it 'stores signing_secret when provided' do
      expect(resource_with_hmac.signing_secret).to eq(signing_secret)
    end

    it 'has nil signing_secret when not provided' do
      expect(resource_without_hmac.signing_secret).to be_nil
    end
  end

  describe 'signature generation' do
    before do
      allow(Time).to receive(:now).and_return(Time.at(1640995200)) # Fixed timestamp: 2022-01-01 00:00:00 UTC
    end

    it 'builds correct signature data for POST request' do
      payload = { 'text' => 'Hello', 'to' => '1234567890' }
      signature_data = resource_with_hmac.send(:build_signature_data, :post, '/sms', payload, '1640995200')
      
      expected = 'POST/sms{"text":"Hello","to":"1234567890"}1640995200'
      expect(signature_data).to eq(expected)
    end

    it 'builds correct signature data for GET request' do
      signature_data = resource_with_hmac.send(:build_signature_data, :get, '/balance', {}, '1640995200')
      
      expected = 'GET/balance1640995200'
      expect(signature_data).to eq(expected)
    end

    it 'generates valid HMAC-SHA256 signature' do
      data = 'test_data'
      signature = resource_with_hmac.send(:generate_hmac_signature, data, signing_secret)
      
      expected = OpenSSL::HMAC.hexdigest('SHA256', signing_secret, data)
      expect(signature).to eq(expected)
    end
  end

  describe 'request headers' do
    let(:stubs) { Faraday::Adapter::Test::Stubs.new }

    before do
      allow(Time).to receive(:now).and_return(Time.at(1640995200)) # Fixed timestamp
      resource_with_hmac.conn.builder.adapter(:test, stubs)
    end

    it 'includes HMAC headers when signing_secret is provided' do
      stubs.post('/api/sms') do |env|
        expect(env.request_headers['X-Timestamp']).to eq('1640995200')
        expect(env.request_headers['X-Signature']).to be_a(String)
        expect(env.request_headers['X-Signature']).to match(/^[a-f0-9]{64}$/) # SHA256 hex format
        expect(env.request_headers['X-Api-Key']).to eq(api_key)
        [200, {}, '{"success": true}']
      end

      resource_with_hmac.retrieve({ 'text' => 'test' })
    end

    it 'does not include HMAC headers when signing_secret is not provided' do
      resource_without_hmac.conn.builder.adapter(:test, stubs)

      stubs.post('/api/sms') do |env|
        expect(env.request_headers['X-Timestamp']).to be_nil
        expect(env.request_headers['X-Signature']).to be_nil
        expect(env.request_headers['X-Api-Key']).to eq(api_key)
        [200, {}, '{"success": true}']
      end

      resource_without_hmac.retrieve({ 'text' => 'test' })
    end
  end
end