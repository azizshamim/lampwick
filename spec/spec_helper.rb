require File.join(File.dirname(__FILE__),'..','lib','lampwick.rb')

RSpec.configure do |config|
  # RSpec automatically cleans stuff out of backtraces;
  # sometimes this is annoying when trying to debug something e.g. a gem
  config.backtrace_clean_patterns = [
      /\/lib\d*\/ruby\//,
      /bin\//,
      /gems/,
      /spec\/spec_helper\.rb/,
      /lib\/rspec\/(core|expectations|matchers|mocks)/
  ]
end
