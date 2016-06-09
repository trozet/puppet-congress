require 'spec_helper'

describe 'congress::db::sync' do

  shared_examples_for 'congress-dbsync' do

    it 'runs congress-db-sync' do
      is_expected.to contain_exec('congress-db-sync').with(
        :command     => 'congress-dbsync --config-file /etc/congress/congress.conf',
        :path        => '/usr/bin',
        :refreshonly => 'true',
        :user        => 'congress',
        :logoutput   => 'on_failure'
      )
    end

  end

  on_supported_os({
    :supported_os   => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge(OSDefaults.get_facts({
          :processorcount => 8,
          :concat_basedir => '/var/lib/puppet/concat'
        }))
      end

      it_configures 'congress-dbsync'
    end
  end

end
