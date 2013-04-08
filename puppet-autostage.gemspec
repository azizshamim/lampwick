# -*- encoding: utf-8 -*-
require File.expand_path('../lib/autostage/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Paul Morgan", "Aziz Shamim"]
  gem.email         = ["jumanjiman@gmail.com", "azizshamim@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.requirements << 'git, >1.7'

  gem.add_dependency('github_api')
  gem.add_development_dependency('system_timer')
  gem.add_development_dependency('rb-fsevent', '~> 0.9')
  gem.add_development_dependency('guard-rspec')
  gem.add_development_dependency('pry')

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "puppet-autostage"
  gem.require_paths = ["lib"]
  gem.version       = Autostage::VERSION
end
