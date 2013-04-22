require 'chefspec'

describe 'postfix-full::default' do
  let(:chef_runner) { ChefSpec::ChefRunner.new(
      :platform => 'ubuntu', :version => '12.04',
      :log_level => :error) }
  let(:chef_run) { chef_runner.converge 'postfix-full::default' }
  let(:main_cf) { '/etc/postfix/main.cf' }
  let(:master_cf) { '/etc/postfix/master.cf' }

  it 'should install postfix package' do
    chef_run.should install_package 'postfix'
  end

  it 'should configure main.cf' do
    chef_run.should create_file main_cf
    file = chef_run.file main_cf
    file.should be_owned_by('root', 0)
  end

  it 'should configure master.cf' do
    chef_run.should create_file master_cf
    file = chef_run.file master_cf
    file.should be_owned_by('root', 0)
  end

  it 'should setup postfix service' do
    chef_run.should start_service 'postfix'
    chef_run.should set_service_to_start_on_boot 'postfix'
  end
end
