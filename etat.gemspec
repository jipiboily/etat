# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'etat/version'

Gem::Specification.new do |spec|
  spec.name          = "etat"
  spec.version       = Etat::VERSION
  spec.authors       = ["Jean-Philippe Boily"]
  spec.email         = ["j@jipi.ca"]
  spec.description   = %q{Etat is a minimalistic gem to help you (me, for now) manage some states in your Rails app.}
  spec.summary       = %q{Etat is a minimalistic gem to help you (me, for now) manage some states in your Rails app. It is built for Rails 4 and assumes the use of ActiveRecord 4.}
  spec.homepage      = "http://github.com/jipiboily/etat"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end