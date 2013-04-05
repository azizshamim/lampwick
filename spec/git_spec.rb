require File.join(File.dirname(__FILE__), 'spec_helper.rb')

describe Autostage::Git, :constraint => 'slow' do
  let(:git) { 'https://github.com/jfryman/puppet-nginx.git' }
  let(:cleanup!) do
    FileUtils.rm_rf("#{@target}/.", :secure => true)
    FileUtils.rm_rf("#{@repo}/.", :secure => true)
  end

  before(:all) do
    @target = File.join(File.dirname(__FILE__),'..','tmp','target')
    @repo = File.join(File.dirname(__FILE__),'..','tmp','repo')
    %x|mkdir -p #{@target}|
    %x|mkdir -p #{@repo}|
  end

  after(:each) do
    cleanup!
  end

  it 'should require git argument' do
    lambda { Autostage::Git.new }.should raise_exception
    lambda { Autostage::Git.new(:git => '') }.should raise_exception
    lambda { Autostage::Git.new(:git => git) }.should_not raise_exception
  end

  it 'should clone a respoitory in the target directory' do
    as = Autostage::Git.new(:git => git, :repo => @repo)
    as.update_or_clone
    Dir["#{@repo}/*"].should_not be_empty
  end

  it 'should create a hash_environment for every branch in the target directory' do
    as = Autostage::Git.new(:git => git, :repo => @repo)
    as.populate_environments(@target)
    hash_environments = Dir["#{@target}/*"]
    hash_environments.should_not be_empty
  end

  it 'should return a list of pull requests' do
    as = Autostage::Git.new(:git => git, :repo => @repo)
    as.pull_requests.should be_a(Hash)
  end

  it 'should created named directories' do
    as = Autostage::Git.new(:git => git, :repo => @repo)
    as.populate_environments(@target)
    pre_naming = Dir["#{@target}/*"]
    as.named_directories(@target)
    post_naming = Dir["#{@target}/*"]
    (post_naming - pre_naming).should_not be_empty
  end
end
