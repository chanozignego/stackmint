# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stackmint'
require 'stackmint/capistrano'

Gem::Specification.new do |spec|
  spec.name          = "stackmint_capistrano"
  spec.version       = Stackmint::Capistrano::VERSION
  spec.authors       = ["Cristian Pereyra"]
  spec.email         = ["cristian@redmintlabs.com"]
  spec.description   = %q{Redmint's application utility belt, capistrano module}
  spec.summary       = %q{Set of capistrano tasks for working with our development stack}
  spec.homepage      = "http://stackmint.redmintlabs.com"

  spec.files         = `git ls-files stackmint_capistrano`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "recap"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
