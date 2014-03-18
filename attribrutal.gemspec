# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'attribrutal/version'

Gem::Specification.new do |spec|
  spec.name        = 'attribrutal'
  spec.version     = Attribrutal::VERSION
  spec.date        = '2014-03-17'
  spec.summary     = "Lazy attribute coercion"
  spec.description = ""
  spec.authors     = ["Bukowskis"]
  spec.email       = ''
  spec.homepage    = ''
  spec.license     = 'MIT'

  spec.files         = `git ls-files`.split($/) - ['.travis.yml']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency('bundler')
  spec.add_development_dependency('rake')
  spec.add_development_dependency('rspec')
end
