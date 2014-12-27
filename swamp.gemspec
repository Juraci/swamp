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
  spec.homepage      = "https://github.com/Juraci/swamp"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "capybara", '~> 2.4'
  spec.add_dependency "selenium-webdriver", '~> 2.43'

  spec.add_development_dependency "bundler", '~> 1.6'
  spec.add_development_dependency "rake", '~> 10.3'
  spec.add_development_dependency "rspec", '~> 3'
  spec.add_development_dependency "cucumber", '~> 1.3'
  spec.add_development_dependency "json", '~> 1.8'
  spec.add_development_dependency "pry", '~> 0.9'
  spec.add_development_dependency "pry-nav", '~> 0.2'
  spec.add_development_dependency "guard", '~> 2.6'
  spec.add_development_dependency "guard-rspec", '~> 4.3'
end
