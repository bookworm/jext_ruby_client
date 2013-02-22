# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jext/version'

Gem::Specification.new do |gem|
  gem.name          = 'jext'
  gem.version       = Jext::VERSION
  gem.authors       = ['K-2052']
  gem.email         = ['k@2052.me']
  gem.description   = %q{Ruby client for the Jext API}
  gem.summary       = %q{Ruby client for the Jext API}
  gem.homepage      = 'http://jext.admincredible.com'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'her'
  gem.add_development_dependency 'rake'
end
