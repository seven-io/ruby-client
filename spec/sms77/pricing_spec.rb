# frozen_string_literal: true

require 'spec_helper'
require 'sms77/resources/pricing'

RSpec.describe Sms77, 'pricing' do
  it 'returns all countries pricing as json' do
    stub = {
      countCountries: 1,
      countNetworks: 4,
      countries: [
        {
          countryCode: 'AT',
          countryName: 'Austria',
          countryPrefix: '43',
          networks: [
            {
              comment: '',
              features: [],
              mcc: '232',
              mncs: ['02'],
              networkName: 'A1 Telekom Austria',
              price: 0.075
            },
            {
              comment: '',
              features: %w[alpha Numeric dlr sc],
              mcc: '232',
              mncs: ['01'],
              networkName: 'A1 Telekom Austria (A1.net)',
              price: 0.075
            }
          ]
        }
      ]
    }

    helper = Helper.new(Sms77::Resources::Pricing)
    res = helper.request(helper.resource.method(:retrieve), stub)
    countries = res[:countries]

    expect(res).to be_a(Hash)
    expect(res[:countCountries]).to be_a(Integer)
    expect(res[:countNetworks]).to be_a(Integer)
    expect(countries).to be_a(Array)

    countries.each do |country|
      networks = country[:networks]

      expect(country).to be_a(Hash)
      expect(country[:countryCode]).to be_a(String)
      expect(country[:countryName]).to be_a(String)
      expect(country[:countryPrefix]).to be_a(String)
      expect(networks).to be_a(Array)

      networks.each do |network|
        mncs = network[:mncs]
        features = network[:features]

        expect(network).to be_a(Hash)
        expect(network[:mcc]).to be_a(String)
        expect(mncs).to be_a(Array)
        mncs.each do |mnc|
          expect(mnc).to be_a(String)
        end
        expect(network[:networkName]).to be_a(String)
        expect(network[:price]).to be_a(Float)
        expect(features).to be_a(Array)
        features.each do |feature|
          expect(feature).to be_a(String)
        end
        expect(network[:comment]).to be_a(String)
      end
    end
  end
end
