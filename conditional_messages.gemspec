# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'conditional_messages/version'

Gem::Specification.new do |spec|
  spec.name          = "conditional_messages"
  spec.version       = ConditionalMessages::VERSION
  spec.authors       = ["iain"]
  spec.email         = ["iain@iain.nl"]
  spec.description   = %q{DSL for creating conditional messages}
  spec.summary       = %q{DSL for creating conditional messages}
  spec.homepage      = "https://github.com/yourkarma/conditional_messages"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "nokogiri"
  spec.add_development_dependency "redcarpet"
end
