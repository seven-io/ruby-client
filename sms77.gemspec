lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'sms77/version'

Gem::Specification.new do |spec|
  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.9'
  spec.add_runtime_dependency 'faraday', '~> 1.1'
  spec.author = 'seven communications GmbH & Co. KG'
  spec.description = 'Send SMS & text-to-speech messages via the seven SMS Gateway.'
  spec.email = 'support@seven.io'
  spec.files = `git ls-files`.split("\n")
  spec.homepage = 'https://github.com/seven-io/ruby-client'
  spec.license = 'MIT'
  spec.name = 'sms77'
  spec.required_ruby_version = '>= 2.6.0'
  spec.summary = 'Official API Client for the seven SMS Gateway'
  spec.test_files = Dir['spec/**/*']
  spec.version = Sms77::VERSION
end