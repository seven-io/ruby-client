# frozen_string_literal: true

require 'spec_helper'
require 'seven_api/resources/subaccounts'

dummy_subaccount = {
  :auto_topup => {
    :amount => 5,
    :threshold => 1,
  },
  :balance => 36.8100,
  :company => 'Company1',
  :contact => {
    :email => 'sms@acme-company1.com',
    :name => 'John Doe',
  },
  :id => '1234567891',
  :total_usage => 0.3000,
  :username => nil,
}

RSpec.describe SevenApi, 'subaccounts' do
  HELPER = Helper.new(SevenApi::Resources::Subaccounts)

  def request(key, stub, extra_params = {})
    HELPER.request(HELPER.resource.method(key), stub, extra_params)
  end

  it 'returns all subaccounts' do
    res = request(:read, [
      dummy_subaccount
    ])

    expect(res).to be_a(Array)

    res.each do |subaccount|
      assert_subaccount(subaccount)
    end
  end

  it 'creates a subaccount' do
    res = request(:create, {
      :error => nil,
      :subaccount => dummy_subaccount,
      :success => true,
    })

    expect(res).to be_a(Hash)
    expect(res[:error]).to be_nil_or_lengthy_string
    assert_subaccount(res[:subaccount])
    expect(res[:success]).to be_boolean
  end

  it 'deletes a subaccount' do
    res = request(
      :delete,
      {
        :error => nil,
        :success => true,
      },
      {
        :id => -1,
      }
    )

    expect(res).to be_a(Hash)
    expect(res[:error]).to be_nil_or_lengthy_string
    expect(res[:success]).to be_boolean
  end

  it 'transfers credits' do
    res = request(
      :transfer_credits,
      {
        :error => nil,
        :success => true,
      },
      {
        :amount => 0,
        :id => -1,
      }
    )

    expect(res).to be_a(Hash)
    expect(res[:error]).to be_nil_or_lengthy_string
    expect(res[:success]).to be_boolean
  end

  it 'updats automatic charging of credits' do
    res = request(
      :update,
      {
        :error => nil,
        :success => true,
      },
      {
        :amount => 0,
        :id => -1,
        :threshold => -1,
      }
    )

    expect(res).to be_a(Hash)
    expect(res[:error]).to be_nil_or_lengthy_string
    expect(res[:success]).to be_boolean
  end

  private

  def assert_subaccount(subaccount)
    expect(subaccount).to be_a(Hash)
    expect(subaccount).to include(:auto_topup, :balance, :company, :contact, :id, :total_usage, :username,)
    expect(subaccount[:auto_topup]).to be_a(Object)
    expect(subaccount[:auto_topup]).to include(:amount, :threshold,)
    expect(subaccount[:balance]).to be_a(Float)
    expect(subaccount[:contact]).to be_a(Object)
    expect(subaccount[:contact]).to include(:email, :name,)
    expect(subaccount[:id]).to be_a(String)
    expect(subaccount[:total_usage]).to be_a(Float)
  end
end
