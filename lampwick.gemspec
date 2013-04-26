# -*- encoding: utf-8 -*-
require File.expand_path('../lib/lampwick/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Paul Morgan", "Aziz Shamim"]
  gem.email         = ["jumanjiman@gmail.com", "azizshamim@gmail.com"]
  gem.description   = %q{"Pull repositories and create puppet environment branches"}
  gem.summary       = %q{"Pull repositories and create puppet environment branches"}
  gem.homepage      = ""

  gem.requirements << 'git, >1.7'

  gem.add_dependency('github_api')
  gem.add_development_dependency('rb-fsevent', '~> 0.9')
  gem.add_development_dependency('guard-rspec')
  gem.add_development_dependency('pry')

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "lampwick"
  gem.require_paths = ["lib"]
  gem.version       = Lampwick::VERSION
end
