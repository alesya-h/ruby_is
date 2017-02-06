# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_is/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby_is"
  spec.version       = RubyIs::VERSION
  spec.authors       = ["Ales Huzik"]
  spec.email         = ["me@aguzik.net"]
  spec.summary       = %q{double is { _1 * 2 }}
  spec.description   = %q{Adds nice syntax for function definition, supporting unnamed arguments (_1, _2, ... _9)}
  spec.homepage      = "https://github.com/alesguzik/ruby-is"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
