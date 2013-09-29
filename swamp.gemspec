# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'swamp/version'

Gem::Specification.new do |spec|
  spec.name          = "swamp"
  spec.version       = Swamp::VERSION
  spec.authors       = ["Juraci de Lima Vieira Neto"]
  spec.email         = ["juraci.vieira@gmail.com"]
  spec.description   = "Automatically generates the methods and selectors to help on faster page-object creation using capybara"
  spec.summary       = "Swamp, where capybaras belong"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "capybara"
  spec.add_dependency "selenium-webdriver"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "json"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-nav"
end
