module Autostage
  class Runner
    class << self; attr_accessor :config, :purge, :named; end
    @config = ''
    @named, @purge = false, false

    def self.run!
      raise ArgumentError, "Need to have a config" if @config.empty?
      config = YAML.load(File.open(self.config))
      git = Autostage::Git.new(config)
      if @purge and !git.config.target.nil?
        puts "Purging #{@config.target}"
        git.purge(@config.target)
      end
      puts "cloning #{git.config.repo} into #{git.config.target}"
      git.update_or_clone
      git.populate_environments
      git.named_directories if @named and git.config.target
    end
  end
end
