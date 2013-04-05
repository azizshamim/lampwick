
module Autostage; end

this = File.expand_path(File.dirname(__FILE__))

require File.join(this, 'autostage', 'version.rb')
require File.join(this, 'autostage', 'runner.rb')
require File.join(this, 'autostage', 'git.rb')
