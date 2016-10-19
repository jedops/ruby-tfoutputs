# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tfoutputs/configurator/version'

Gem::Specification.new do |spec|
  spec.name          = 'tfoutputs'
  spec.version       = TfOutputs::Configurator::VERSION
  spec.authors       = ['James Edwards']
  spec.email         = ['admin@jaetech.org']

  spec.summary       = 'Gem for grabbing variables from terraform'
  spec.description   = 'it does stuff'
  spec.homepage      = 'https://jaetech.org'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|fixtures)/}) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop'
  spec.add_runtime_dependency 'aws-sdk', '~> 2'
  spec.add_runtime_dependency 'activesupport', '~> 5'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'vcr', '~>3.0'
  spec.add_development_dependency 'webmock', '~> 2.1'
end
