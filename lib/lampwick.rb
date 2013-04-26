require 'yaml'
require 'json'

module Lampwick; end

this = File.expand_path(File.dirname(__FILE__))

require File.join(this, 'lampwick', 'version.rb')
require File.join(this, 'lampwick', 'runner.rb')
require File.join(this, 'lampwick', 'git.rb')
