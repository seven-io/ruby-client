lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'sms77/version'

Gem::Specification.new do |spec|
  spec.name = 'sms77'
  spec.version = Sms77::VERSION.dup
  spec.summary = 'Official Sms77.io API Client for Ruby'
  spec.description = 'Send SMS & Text2Voice messages via the Sms77.io SMS Gateway.'
  spec.authors = ['sms77 e.K.']
  spec.email = ['support@sms77.io']
  spec.homepage = 'https://github.com/sms77io/ruby-client'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.5'
  spec.require_paths = ['lib']
  spec.files = `git ls-files`.split("\n")
  spec.test_files = Dir['test/**/*']

  spec.add_runtime_dependency 'faraday', '~> 1'

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'rake', '~> 13'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
