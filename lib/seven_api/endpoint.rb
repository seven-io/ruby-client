# frozen_string_literal: true

# This module exposes the endpoints covered by this client.
module SevenApi::Endpoint
  ANALYTICS = 'analytics'
  BALANCE = 'balance'
  CONTACTS = 'contacts'
  GROUPS = 'groups'
  HOOKS = 'hooks'
  JOURNAL = 'journal'
  LOOKUP = 'lookup'
  NUMBERS = 'numbers'
  PRICING = 'pricing'
  RCS = 'rcs'
  RCS_EVENTS = RCS + '/events'
  RCS_MESSAGES = RCS + '/messages'
  SMS = 'sms'
  STATUS = 'status'
  SUBACCOUNTS = 'subaccounts'
  VALIDATE_FOR_VOICE = 'validate_for_voice'
  VOICE = 'voice'
end
