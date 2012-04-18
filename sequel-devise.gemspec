# -*- encoding: utf-8 -*-
require File.expand_path('../lib/sequel-devise/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Rodrigo Rosenfeld Rosas"]
  gem.email         = ["rr.rosas@gmail.com"]
  gem.description   = %q{Devise support for Sequel models}
  gem.summary       = %q{Enable Devise support by adding plugin :devise to your Sequel Model}
  gem.homepage      = "https://github.com/rosenfeld/sequel-devise"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "sequel-devise"
  gem.require_paths = ["lib"]
  gem.version       = Sequel::Devise::VERSION
end
