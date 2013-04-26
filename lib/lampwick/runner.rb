module Lampwick
  class Runner
    class << self; attr_accessor :config, :purge, :named; end
    @config = ''
    @named, @purge = false, false

    def self.run!
      raise ArgumentError, "Need to have a config" if @config.empty?
      f = File.open(@config)
      config = ::YAML::load(f)
      git = Lampwick::Git.new(config)
      if @purge and !git.config.target.nil?
        puts "Purging #{git.config.target}"
        Dir.chdir git.config.target do
          FileUtils.rm_rf(".", :secure => true)
        end
      end
      git.update_or_clone
      git.populate_environments
      git.named_directories if @named and git.config.target
    end
  end
end
