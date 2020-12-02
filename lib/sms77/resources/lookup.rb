# frozen_string_literal: true

require 'sms77/resource'
module Sms77::Resources
  class Lookup < Sms77::Resource
    @endpoint = Sms77::Endpoint::LOOKUP
    @http_methods = {
      :cnam => :post,
      :format => :post,
      :hlr => :post,
      :mnp => :post,
    }

    def cnam(params)
      request(params.merge({ :type => Sms77::Lookup::Type::CNAM }))
    end

    def format(params)
      request(params.merge({ :type => Sms77::Lookup::Type::FORMAT }))
    end

    def hlr(params)
      request(params.merge({ :type => Sms77::Lookup::Type::HLR }))
    end

    def mnp(params)
      request(params.merge({ :type => Sms77::Lookup::Type::MNP }))
    end
  end
end