describe Autostage::Runner, :focus => true do
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

    content =<<-EOF
    ---
      git: 'https://github.com/jfryman/puppet-nginx.git'
      user: 'fup'
      password: 'notArealP@ssword'
      target: '#{@target}'
      repo: '#{@repo}'
    EOF

    @autostage_conf = File.join(@tmpdir,'autostage.conf')
    File.open(@autostage_conf, 'w') {|f| f.write(content) }
  end

  after(:each) do
    cleanup!
  end

  after(:all) do
    FileUtils.rm_rf("#{@tmpdir}/.", :secure => true)
  end


  subject { Autostage::Runner }
  it { should respond_to(:run!) }

  it 'should store config' do
    subject.config.should be_empty
  end

  it 'should store purge' do
    subject.purge.should be_false
  end

  it 'should store named' do
    subject.named.should be_false
  end

  it 'should load up a config file' do
    subject.config = @autostage_conf
    subject.config.should_not be_empty
  end

  it 'should run!' do
    subject.config = @autostage_conf
    lambda { subject.run!.should_not raise_execption }
    subject.run!
  end

end
