# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'monadist/version'

Gem::Specification.new do |spec|
  spec.name          = "monadist"
  spec.version       = Monadist::VERSION
  spec.authors       = ["Zoltan Ormandi"]
  spec.email         = ["zoltan.ormandi@gmail.com"]
  spec.summary       = %q{Practical implementation of a couple of popular monads.}
  spec.description   = %q{A practical and useful Ruby implementation of a couple of popular monads. Method naming follows the Haskell convention so the gem can be used for trying to understand monads (mostly described in tutorials using Haskell).}
  spec.homepage      = "https://github.com/zormandi/monadist"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
