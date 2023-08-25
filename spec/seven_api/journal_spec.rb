# frozen_string_literal: true

require 'spec_helper'
require 'seven_api/journal'
require 'seven_api/resources/journal'
require 'seven_api/sms'

RSpec.describe SevenApi, 'journal' do
  def valid_timestamp?(str)
    str.match(/[\d]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][\d]|3[0-1]) (2[0-3]|[01][\d]):[0-5][\d]/)
  end

  def request(type)
    stub = [{
              :from => "SMS",
              :id => "123456789",
              :price => "1.2",
              :text => "Hey my friend!",
              :timestamp => "2020-10-14 14:25:04",
              :to => "49170123456789",
            }]

    helper = Helper.new(SevenApi::Resources::Journal)
    res = helper.request(helper.resource.method(:retrieve), stub, { type: type })

    expect(res).to be_a(Array)

    res.each do |journal|
      expect(journal).to be_a(Hash)
      expect(journal[:from]).to be_lengthy_string
      expect(journal[:id]).to be_numeric
      expect(SevenApi::Util::valid_float?(journal[:price])).to be_truthy
      expect(journal[:text]).to be_lengthy_string
      expect(valid_timestamp?(journal[:timestamp])).to be_truthy
      expect(journal[:to]).to be_lengthy_string
    end

    res
  end

  it 'returns all inbound messages' do
    request(SevenApi::Journal::Type::INBOUND)
  end

  it 'returns all outbound messages' do
    request(SevenApi::Journal::Type::OUTBOUND).each do |journal|
      journal.merge!({
                       :connection => "http",
                       :dlr => "DELIVERED",
                       :dlr_timestamp => "2020-10-04 09:26:10.000",
                       :foreign_id => "MyForeignId",
                       :label => "MyCustomLabel",
                       :latency => "5.1060",
                       :mccmnc => "26207",
                       :type => "direct",
                     })
      expect(journal[:connection]).to be_lengthy_string
      expect(journal[:dlr]).to be_nil_or_lengthy_string
      expect(valid_timestamp?(journal[:dlr_timestamp])).to be_truthy
      expect(journal[:foreign_id]).to be_nil_or_lengthy_string
      expect(journal[:label]).to be_nil_or_lengthy_string
      expect(journal[:latency]).to be_nil_or_lengthy_string
      expect(journal[:mccmnc]).to be_nil_or_lengthy_string
      expect(SevenApi::Util::in_module_constants?(journal[:type], SevenApi::Sms::Type)).to be_truthy
    end
  end

  it 'returns all voice messages' do
    request(SevenApi::Journal::Type::VOICE).each do |journal|
      journal.merge!({
                       :duration => "2",
                       :error => "",
                       :status => "completed",
                       :xml => false,
                     })
      expect(journal[:duration]).to be_numeric
      expect(journal[:error]).to be_nil_or_lengthy_string
      expect(journal[:status]).to be_lengthy_string
      expect(journal[:xml]).to be_boolean
    end
  end

  it 'returns all reply messages' do
    request(SevenApi::Journal::Type::REPLIES)
  end
end
