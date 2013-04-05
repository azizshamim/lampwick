#!/usr/bin/env rake
require "bundler/gem_tasks"
require "bundler"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = ' -r ./spec/spec_helper'
  t.rspec_opts += ' --tag focus'
end

RSpec::Core::RakeTask.new(:spec_all)

task :default => :spec_all

task :guard do
  Bundler.setup
  exec("guard")
end
