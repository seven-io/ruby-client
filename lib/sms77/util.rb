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

  def self.valid_float?(str)
    !!Float(str) rescue false
  end

  def self.numeric?(val)
    return true if val.is_a?(Integer)

    val.scan(/\D/).empty?
  end

  def self.boolean?(val)
    [true, false].include? val
  end

  def self.nil_or_lengthy_string?(val)
    val.nil? || (val.is_a?(String) && val.length)
  end

  def self.lengthy_string?(val)
    return val.is_a?(String) && !val.empty?
  end
end