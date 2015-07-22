# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tfl_api_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'tfl_api_client'
  spec.version       = TflApi::VERSION
  spec.author        = 'Luke Hackett'
  spec.email         = 'Luke.Hackett@live.co.uk'
  spec.homepage      = 'https://github.com/LukeHackett/tfl_api_client'
  spec.license       = 'MIT'
  spec.platform      = Gem::Platform::RUBY
  spec.summary       = 'Transport for London API Client'
  spec.description   = <<-eof
    This gem aims to provide a simple, programmatic ruby client that allows
    native ruby applications to seamlessly interact with the Transport for
    London's live APIs.
  eof

  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ['lib']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'yard', '~> 0.8.7'

  spec.add_development_dependency 'rspec', '~> 3.3'
  spec.add_development_dependency 'vcr', '~> 2.9'
  spec.add_development_dependency 'webmock', '~> 1.21'
  spec.add_development_dependency 'simplecov', '~> 0.10'
end
