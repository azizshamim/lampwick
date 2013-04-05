describe Autostage::Runner, :focus => true do
  it 'should have a config accessor' do
    Autostage::Runner.config.should be_empty
  end

  it 'should have a run! class method' do
    pending
    Autostage::Runner.should respond_to?(:run!)
  end
end
