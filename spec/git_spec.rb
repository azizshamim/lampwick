require File.join(File.dirname(__FILE__), 'spec_helper.rb')

describe Lampwick::Git, :constraint => 'slow', :focus => true do
  let(:git) { 'https://github.com/jfryman/puppet-nginx.git' }
  let(:cleanup!) do
    FileUtils.rm_rf("#{@target}/.", :secure => true)
    FileUtils.rm_rf("#{@repo}/.", :secure => true)
  end

  before(:all) do
    @tmpdir = Dir.mktmpdir
    @target = File.join(@tmpdir,'target')
    @repo = File.join(@tmpdir,'repo')
    %x|mkdir -p #{@target}|
    %x|mkdir -p #{@repo}|
  end

  after(:each) do
    cleanup!
  end

  after(:all) do
    FileUtils.rm_rf("#{@tmpdir}/.", :secure => true)
  end

  it 'should require git argument' do
    lambda { Lampwick::Git.new }.should raise_exception
    lambda { Lampwick::Git.new(:git => '') }.should raise_exception
    lambda { Lampwick::Git.new(:git => git) }.should_not raise_exception
  end

  it 'should clone a respoitory in the target directory' do
    as = Lampwick::Git.new(:git => git, :repo => @repo)
    as.update_or_clone
    Dir["#{@repo}/*"].should_not be_empty
  end

  it 'should create a hash_environment for every branch in the target directory' do
    as = Lampwick::Git.new(:git => git, :repo => @repo)
    as.update_or_clone
    as.populate_environments(@target)
    hash_environments = Dir["#{@target}/*"]
    hash_environments.should_not be_empty
  end

  it 'should return a list of pull requests' do
    as = Lampwick::Git.new(:git => git, :repo => @repo)
    as.update_or_clone
    as.pull_requests.should be_a(Hash)
  end

  it 'should created named directories' do
    as = Lampwick::Git.new(:git => git, :repo => @repo)
    as.update_or_clone
    as.populate_environments(@target)
    pre_naming = Dir["#{@target}/*"]
    as.named_directories(@target)
    post_naming = Dir["#{@target}/*"]
    (post_naming - pre_naming).should_not be_empty
  end
end
