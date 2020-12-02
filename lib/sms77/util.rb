require 'date'

module Sms77::Util
  def self.to_numbered_bool(val)
    if true == val
      return 1
    elsif false == val
      return 0
    end

    return val
  end

  def self.get_namespace_members_by_type(ns, type)
    ns.constants.map(&ns.method(:const_get)).grep(type)
  end

  def self.get_namespace_classes(ns)
    return self.get_namespace_members_by_type(ns, Class)
  end

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