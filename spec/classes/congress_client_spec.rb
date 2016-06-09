require 'spec_helper'

describe 'congress::client' do

  shared_examples_for 'congress client' do

    it { is_expected.to contain_class('congress::params') }

    it 'installs congress client package' do
      is_expected.to contain_package('python-ceilometerclient').with(
        :ensure => 'present',
        :name   => 'python-ceilometerclient',
        :tag    => 'openstack',
      )
    end
  end

  on_supported_os({
    :supported_os   => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

      it_configures 'congress client'
    end
  end

end
