# frozen_string_literal: true

require 'spec_helper'
require 'sms77/endpoint'
require 'sms77/contacts_action'

RSpec.describe Sms77, 'contacts' do
  $new_contact_id = nil

  def assert_new(response_body)
    if response_body.is_a?(String)
      code, $new_contact_id = response_body.split("\n")
      $new_contact_id = $new_contact_id.to_i
    else
      code = response_body['return']
      $new_contact_id = response_body['id']
    end

    expect(code).to be_numeric
    expect($new_contact_id).to be_an_instance_of(Integer)
  end

  def assert_contact(contact)
    if contact.is_a?(String)
      id, name, number = contact.split(';')

      id = id.gsub('"', '')
      name = name.gsub('"', '')
      number = number.gsub('"', '')
    else
      id = contact['ID']
      name = contact['Name']
      number = contact['Number']
    end

    expect(id).to be_numeric
    expect(name).to be_an_instance_of(String)
    expect(number.sub('+', '')).to be_numeric
  end

  def request(action, stub, extra_params = {})
    Helper.method(Sms77::ContactsAction::READ == action ? :get : :post)
          .call(Sms77::Endpoint::CONTACTS, stub, { action: action }.merge(extra_params))
  end

  it 'returns all contacts as CSV' do
    stub = <<~CSV
      "4848436";"";""
      "4848437";"";""
      "4848433";"Alf Albert";"007"
      "3172517";"BNN Nolte";"004911112"
      "4848434";"Harry Harald";"0049123456"
      "4848431";"Karl Konrad";"00123456"
      "4848432";"Petra Pan";"00513414"
      "2925186";"Tom Tester";"004901234567890"
    CSV

    body = request(Sms77::ContactsAction::READ, stub)

    expect(body).to be_kind_of(String)

    body.split("\n").each do |contact|
      assert_contact(contact)
    end
  end

  it 'returns all contacts as JSON' do
    stub = [
      { ID: '4848436', Name: '', Number: '' },
      { ID: '4848437', Name: '', Number: '' },
      { ID: '4848433', Name: 'Alf Albert', Number: '007' },
      { ID: '3172517', Name: 'BNN Nolte', Number: '004911112' },
      { ID: '4848434', Name: 'Harry Harald', Number: '0049123456' },
      { ID: '4848431', Name: 'Karl Konrad', Number: '00123456' },
      { ID: '4848432', Name: 'Petra Pan', Number: '00513414' },
      { ID: '2925186', Name: 'Tom Tester', Number: '004901234567890' }
    ]

    body = request(Sms77::ContactsAction::READ, stub, { json: 1 })

    expect(body).to be_kind_of(Array)

    body.each do |contact|
      assert_contact(contact)
    end
  end

  it 'creates a contact and returns its ID as TEXT' do
    stub = <<~TEXT
      152
      4868400
    TEXT

    body = request(Sms77::ContactsAction::WRITE, stub)

    expect(body).to be_kind_of(String)

    assert_new(body)
  end

  it 'deletes a contact with given ID and return code' do
    expect(request(Sms77::ContactsAction::DEL, 152, { id: $new_contact_id })).to be_kind_of(Integer)
  end

  it 'creates a contact and returns its ID as JSON' do
    body = request(Sms77::ContactsAction::WRITE, { id: 4868401, return: '152' }, { json: 1 })

    expect(body).to be_kind_of(Hash)

    assert_new(body)
  end

  it 'deletes a contact with given ID and return code as JSON' do
    body = request(Sms77::ContactsAction::DEL, { return: '152' }, { id: $new_contact_id, json: 1 })

    expect(body).to be_kind_of(Hash)
    expect(body['return']).to be_kind_of(String)
  end
end
