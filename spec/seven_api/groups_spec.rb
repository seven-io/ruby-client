# frozen_string_literal: true

require 'spec_helper'
require 'seven_api/resources/groups'

dummy_group = {
  "created": "2023-12-21 21:59:53",
  "id": 17923,
  "members_count": 543,
  "name": "Group 1",
}

RSpec.describe SevenApi, 'groups' do
  $new_number_id = nil

  def assert_new(response_body)
    code = response_body[:return]
    $new_number_id = response_body[:id]

    expect(code).to be_numeric
    expect($new_number_id).to be_an_instance_of(Integer)
  end

  def assert_group(group)
    expect(group[:id]).to be_numeric
    expect(group[:name]).to be_an_instance_of(String)
  end

  it 'returns all groups' do
    stub = {
      data: [
        dummy_group,
        dummy_group
      ],
      pagingMetadata: {
        count: 30,
        has_more: true,
        offset: 0,
        total: 20013
      },
    }

    helper = Helper.new(SevenApi::Resources::Groups)
    body = helper.request(helper.resource.method(:all), stub)

    expect(body).to be_a(Array)

    body.each do |group|
      assert_group(group)
    end
  end

  it 'creates a group and returns its ID' do
    stub = dummy_group
    helper = Helper.new(SevenApi::Resources::Groups)
    body = helper.request(helper.resource.method(:create), stub)

    expect(body).to be_a(Hash)

    assert_new(body)
  end

  it 'deletes a group with given ID' do
    helper = Helper.new(SevenApi::Resources::Groups)
    body = helper.request(
      helper.resource.method(:delete),
      nil,
      0
    )

    expect(body).to be_a(Hash)
    expect(body[:return]).to be_a(String)
  end
end
