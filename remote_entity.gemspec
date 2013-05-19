# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'remote_entity/version'

Gem::Specification.new do |spec|
  spec.name          = "remote_entity"
  spec.version       = RemoteEntity::VERSION
  spec.authors       = ["Alan Johnson", "Taylor Shuler"]
  spec.email         = ["alan@gnoso.com", "taylorshuler@aol.com"]
  spec.description   = %q{Remote Entity defines a pattern for working with REST services. It defines a versioning scheme, a remote entity identifier scheme, and adds some useful features to ActiveRecord and ActiveResource for working with those schemes.}
  spec.summary       = %q{Remote Entity defines a pattern for working with REST services.}
  spec.homepage      = "https://github.com/gnoso/remote_entity"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.add_dependency "activeresource", ">= 2.0"
  spec.add_dependency "activerecord", ">= 2.0"
  
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end