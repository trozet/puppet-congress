require 'spec_helper'

describe 'congress::auth' do

  let :params do
    { :auth_url         => 'http://localhost:5000/v2.0',
      :auth_region      => 'RegionOne',
      :auth_user        => 'congress',
      :auth_password    => 'password',
      :auth_tenant_name => 'services',
    }
  end

  shared_examples_for 'congress-auth' do

    it 'configures authentication' do
      is_expected.to contain_congress_config('service_credentials/os_auth_url').with_value('http://localhost:5000/v2.0')
      is_expected.to contain_congress_config('service_credentials/os_region_name').with_value('RegionOne')
      is_expected.to contain_congress_config('service_credentials/os_username').with_value('congress')
      is_expected.to contain_congress_config('service_credentials/os_password').with_value('password')
      is_expected.to contain_congress_config('service_credentials/os_password').with_value(params[:auth_password]).with_secret(true)
      is_expected.to contain_congress_config('service_credentials/os_tenant_name').with_value('services')
      is_expected.to contain_congress_config('service_credentials/os_cacert').with(:ensure => 'absent')
    end

    context 'when overriding parameters' do
      before do
        params.merge!(
          :auth_cacert        => '/tmp/dummy.pem',
          :auth_endpoint_type => 'internalURL',
        )
      end
      it { is_expected.to contain_congress_config('service_credentials/os_cacert').with_value(params[:auth_cacert]) }
      it { is_expected.to contain_congress_config('service_credentials/os_endpoint_type').with_value(params[:auth_endpoint_type]) }
    end

  end

  on_supported_os({
    :supported_os   => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

      it_configures 'congress-auth'
    end
  end

end
