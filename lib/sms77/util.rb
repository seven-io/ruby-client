require 'date'

module Sms77::Util
  def self.get_module_constant_values(mod)
    mod.constants(false).map &mod.method(:const_get)
  end

  def self.is_valid_url?(str)
    str =~ URI::regexp
  end

  def self.is_valid_datetime?(str)
    begin
      DateTime.parse(str)
      true
    rescue ArgumentError
      false
    end
  end

  def self.is_positive_integer?(val)
    /\A\d+\z/.match?(val.to_s)
  end

  def self.in_module_constants?(needle, mod)
    get_module_constant_values(mod).include?(needle)
  end
end