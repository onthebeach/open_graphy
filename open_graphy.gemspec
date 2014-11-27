# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'open_graphy/version'

Gem::Specification.new do |spec|
  spec.name          = "open_graphy"
  spec.version       = OpenGraphy::VERSION
  spec.authors       = ["Craig Bradley", "James Cotterill"]
  spec.email         = ["craig-bradley@onthebeach.co.uk", "james.cotterill@onthebeach.co.uk" ]
  spec.summary       = %q{Open Graph Protocol wrapper}
  spec.description   = %q{A simple ruby wrapper for the open graph protocol}
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "nokogiri", "~> 1.6"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "vcr", '~> 2.9'
  spec.add_development_dependency "webmock", "~> 1.20"
end
