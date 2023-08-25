RSpec::Matchers.define :be_nil_or_lengthy_string do
  match do |val|
    SevenApi::Util::nil_or_lengthy_string?(val)
  end
end

RSpec::Matchers.define :be_boolean do
  match do |val|
    SevenApi::Util::boolean?(val)
  end
end

RSpec::Matchers.define :be_numeric do
  match do |val|
    SevenApi::Util::numeric?(val)
  end
end

RSpec::Matchers.define :be_lengthy_string do
  match do |val|
    SevenApi::Util::lengthy_string?(val)
  end
end