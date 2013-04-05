module Autostage
  class Runner
    class << self; attr_accessor :config; end
    @config = ''

    def self.run!
      config = YAML.load(File.open(self.config))
    end
  end
end
