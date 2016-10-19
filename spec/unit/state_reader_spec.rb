require 'spec_helper'

describe 'state reader' do
  before(:each) do
    cwd = File.expand_path(File.dirname(__FILE__))
    @tf_state = "#{cwd}/resources/terraform.tfstate"
  end

  it 'should get outputs' do
    sr = TfOutputs::Configurator::StateReader.new(@tf_state => false)
    expected = { 'allowed_ips' => { 'sensitive' => false, 'type' => 'string', 'value' => '10.5.1.6/32' } }
    expect(sr.outputs).to include(expected)
  end
  it 'method missing should work' do
    sr = TfOutputs::Configurator::StateReader.new(@tf_state => false)
    expect(sr.allowed_ips).to eq('10.5.1.6/32')
  end
  it "method missing should fail when a variable from state file isn't returned" do
    sr = TfOutputs::Configurator::StateReader.new(@tf_state => false)
    expect { sr.bastion_ipasdad }.to raise_error(NoMethodError)
  end

  it 'should return sensitive for a sensitive value' do
    sr = TfOutputs::Configurator::StateReader.new(@tf_state => false)
    expect(sr.cf_admin_pass).to eq('sensitive')
  end
end
