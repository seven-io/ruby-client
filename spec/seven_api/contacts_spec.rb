# frozen_string_literal: true

require 'spec_helper'
require 'seven_api/contacts'
require 'seven_api/resources/contacts'

dummy_contact = {
  "id": 12876882,
  "avatar": "https://static.seven.io/uploads/contact_images/4A000c0d4e9431F483090dE8D13F3806.jpg",
  "validation": {
    "state": nil,
    "timestamp": nil
  },
  "initials": {
    "initials": "",
    "color": "EEE0C9"
  },
  "properties": {
    "address": nil,
    "birthday": nil,
    "city": nil,
    "email": nil,
    "firstname": nil,
    "home_number": nil,
    "lastname": nil,
    "mobile_number": nil,
    "notes": nil,
    "postal_code": nil,
  },
  "groups": [
  ],
  "created": "2024-01-09 13:12:48"
}

RSpec.describe SevenApi, 'contacts' do
  $new_contact_id = nil

  def assert_new(response_body)
    if response_body.is_a?(String)
      code, $new_contact_id = response_body.split("\n")
      $new_contact_id = $new_contact_id.to_i
    else
      code = response_body[:return]
      $new_contact_id = response_body[:id]
    end

    expect(code).to be_numeric
    expect($new_contact_id).to be_an_instance_of(Integer)
  end

  def assert_contact(contact)
    id = contact[:ID]
    name = contact[:Name]
    number = contact[:Number]

    expect(id).to be_numeric
    expect(name).to be_an_instance_of(String)
    expect(number.sub('+', '')).to be_numeric
  end

  it 'returns all contacts' do
    stub = {
      data: [
        dummy_contact,
        dummy_contact
      ],
      pagingMetadata: {
        count: 30,
        has_more: true,
        offset: 0,
        total: 20013
      },
    }

    helper = Helper.new(SevenApi::Resources::Contacts)
    body = helper.request(helper.resource.method(:all), stub)

    expect(body).to be_a(Array)

    body.each do |contact|
      assert_contact(contact)
    end
  end

  it 'creates a contact and returns its ID as JSON' do
    stub = dummy_contact
    helper = Helper.new(SevenApi::Resources::Contacts)
    body = helper.request(helper.resource.method(:create), stub)

    expect(body).to be_a(Hash)

    assert_new(body)
  end

  it 'deletes a contact with given ID and return code as JSON' do
    helper = Helper.new(SevenApi::Resources::Contacts)
    body = helper.request(
      helper.resource.method(:delete),
      nil,
      0
    )

    expect(body).to be_a(Hash)
    expect(body[:return]).to be_a(String)
  end
end
