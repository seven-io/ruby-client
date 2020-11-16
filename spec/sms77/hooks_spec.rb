# frozen_string_literal: true

require 'securerandom'
require 'sms77/hooks'
require 'sms77/util'
require 'spec_helper'

RSpec.describe Sms77, 'hooks' do
  HOOK_ID = EnvKeyStore.new('HOOK_ID')

  def alter_action_stub
    {
      :code => nil,
      :success => true
    }
  end

  def request(action, stub, extra_params = {})
    res = Helper.method(Sms77::Hooks::Action::READ == action ? :get : :post)
                .call(Sms77::Endpoint::HOOKS, stub, { action: action }.merge(extra_params))
                .transform_keys(&:to_sym)

    res[:hooks].map! { |hash| hash.transform_keys(&:to_sym) } if res.key?(:hooks)

    expect(res).to be_a(Hash)

    stub_keys = stub.keys
    res.each do |k, v|
      expect(stub_keys).to include(k)
      expect(v.class).to match(stub[:"#{k}"].class)
    end

    res
  end

  it 'returns all hooks' do
    res = request(Sms77::Hooks::Action::READ, {
      :code => nil,
      :hooks => [
        {
          :created => "2020-11-04 23:04:15",
          :event_type => "sms_mo",
          :id => "30",
          :request_method => "GET",
          :target_url => "http:\/\/my.tld\/testHook"
        }
      ],
      :success => true
    })

    res[:hooks].each do |hook|
      expect(Sms77::Util::is_valid_datetime?(hook[:created])).to be
      expect(hook[:created] =~ /^\d\d\d\d-(0?[1-9]|1[0-2])-(0?[1-9]|[12][0-9]|3[01]) (00|[0-9]|1[0-9]|2[0-3]):([0-9]|[0-5][0-9]):([0-9]|[0-5][0-9])$/).to be
      expect(Sms77::Hooks::Validator::event_type?(hook[:event_type])).to be
      expect(Sms77::Util::is_positive_integer?(hook[:id])).to be
      expect(Sms77::Hooks::Validator::request_method?(hook[:request_method])).to be
      expect(Sms77::Hooks::Validator::target_url?(hook[:target_url])).to be
    end
  end

  it 'subscribes' do
    stub = alter_action_stub.merge({ :id => rand(1...1000000) })

    res = request(Sms77::Hooks::Action::SUBSCRIBE, stub, {
      :event_type => Sms77::Hooks::EventType::NEW_INBOUND_SMS,
      :request_method => Sms77::Hooks::RequestMethod::GET,
      :target_url => "http://ruby.tld/#{SecureRandom.uuid}"
    })

    expect(Sms77::Util::is_positive_integer?(res[:id])).to be
    expect(res[:id]).to be_a(Integer)
    expect(stub[:id]).to match(res[:id]) unless Helper.is_http

    assert_alter_response(res)

    puts "Subscribed ID: #{Helper.is_http ? res[:id] : stub[:id]}"

    HOOK_ID.set(res[:id])
  end

  it 'unsubscribes' do
    id = HOOK_ID.get
    res = request(Sms77::Hooks::Action::UNSUBSCRIBE, alter_action_stub, { :id => id })

    assert_alter_response(res)

    expect(res[:success]).to be_boolean

    puts "Unsubscribed ID #{id}: #{res[:success]}"

    res[:success]
  end

  def assert_alter_response(res)
    expect(res[:code]).to match(nil)
    expect(res[:success]).to be_boolean
  end
end