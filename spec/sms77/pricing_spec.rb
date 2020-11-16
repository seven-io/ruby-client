# frozen_string_literal: true

require 'spec_helper'
require 'sms77/endpoint'
require 'json'

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

    res = Helper.get(Sms77::Endpoint::PRICING, stub)
    countries = res[:countries]

    expect(res).to be_kind_of(Hash)
    expect(res[:countCountries]).to be_kind_of(Integer)
    expect(res[:countNetworks]).to be_kind_of(Integer)
    expect(countries).to be_kind_of(Array)

    countries.each do |country|
      networks = country[:networks]

      expect(country).to be_kind_of(Hash)
      expect(country[:countryCode]).to be_kind_of(String)
      expect(country[:countryName]).to be_kind_of(String)
      expect(country[:countryPrefix]).to be_kind_of(String)
      expect(networks).to be_kind_of(Array)

      networks.each do |network|
        mncs = network[:mncs]
        features = network[:features]

        expect(network).to be_kind_of(Hash)
        expect(network[:mcc]).to be_kind_of(String)
        expect(mncs).to be_kind_of(Array)
        mncs.each do |mnc|
          expect(mnc).to be_kind_of(String)
        end
        expect(network[:networkName]).to be_kind_of(String)
        expect(network[:price]).to be_kind_of(Float)
        expect(features).to be_kind_of(Array)
        features.each do |feature|
          expect(feature).to be_kind_of(String)
        end
        expect(network[:comment]).to be_kind_of(String)
      end
    end
  end
end
