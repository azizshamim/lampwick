require 'ostruct'
require 'tmpdir'
require 'uri'
require 'github_api'

module Autostage
  class Git
    attr_reader :config
    REQUIRED_INITIAL = [ :git ]
    # pass a git repository, access credentials to the git repo (username/password or path to an ssh key)
    # { :git => '', :user => 'foo', :password => 'bar', :key => 'path/to/key' }
    # returns a new autostage object
    def initialize(config)
      @config = ::OpenStruct.new(config)
      REQUIRED_INITIAL.each do |arg|
        raise ArgumentError, "Needs the #{arg} argument"         unless  @config.respond_to?(arg)
        raise ArgumentError, "#{arg} argument cannot be empty/blank"  if @config.__send__(arg.to_s).nil? or @config.__send__(arg.to_s).empty?
      end
      @config.git = URI(@config.git)
    end

    def update_or_clone(repo = @config.repo)
      if @config.git.scheme == 'https'
        %x|git clone --quiet #{@config.git} #{repo}| unless repo_exists?(repo)
      end
    end

    def pull_requests(repo = @config.repo)
      raise StandardError, "Repo has not been cloned at: #{repo}" unless repo_exists?(repo)
      refs = Hash.new
      Dir.chdir @config.repo do
        %x|git fetch --quiet origin '+refs/pull/*/head:refs/remotes/origin/pr/*'|
        refs = %x|git show-ref --dereference|
        flipped_refs = refs.split("\n").map{|ab| ab.split(/\s+/).reverse }.flatten
        refs = Hash[*flipped_refs].delete_if { |ref,hash| ref !~ /origin\/pr\/\d+$/ }
      end
      refs
    end

    def populate_environments(target = @config.target)
      raise StandardError, "Repo has not been cloned at: #{repo}" unless repo_exists?(@config.repo)
      Dir.chdir target do
        pull_requests.each do |ref, hash|
          %x|git clone #{@config.repo} #{target}/#{hash}|
          Dir.chdir "#{target}/#{hash}" do
            %x|git checkout --quiet #{hash}|
          end
        end
      end
    end

    def named_directories(target = @config.target)
      Dir.chdir target do
        github_requests.each do |hash,name|
          File.symlink(hash, name)
        end
      end
    end

    private
    def repo_exists?(repo = @config.repo)
      File.exist? "#{repo}/.git/config"
    end

    def purge!
      raise StandardError, "Unsafe purge halted" if @config.target.empty?
      Dir.chdir @config.target do
        FileUtils.rm_rf(".", :secure => true)
      end
    end

    def repo
      @config.git.path.split('/').last.chomp('.git')
    end

    def github_requests
      github = Github.new
      reqs = Hash.new
      github.pull_requests.list(:repo => repo, :user => user) do |req|
        reqs[req['head']['sha']] = "#{req['user']['login']}_#{req['head']['ref']}"
      end
      reqs
    end

    def user
      @config.git.path.split('/')[-2]
    end
  end
end
