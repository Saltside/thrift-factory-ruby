# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thrift/factory/version'

Gem::Specification.new do |spec|
  spec.name          = 'thrift-factory'
  spec.version       = Thrift::Factory::VERSION
  spec.authors       = ['Terje Larsen']
  spec.email         = ['terje@saltside.se']
  spec.summary       = %q{Thrift struct factory}
  spec.description   = %q{}
  spec.homepage      = 'https://github.com/saltside/thrift-factory-ruby'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'thrift'

  spec.add_development_dependency 'thrift-validator'
  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
