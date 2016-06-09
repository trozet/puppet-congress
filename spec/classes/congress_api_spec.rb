require 'spec_helper'

describe 'congress::api' do

  let :pre_condition do
    "class { 'congress': }
     include ::congress::db"
  end

  let :params do
    { :enabled           => true,
      :manage_service    => true,
      :keystone_password => 'congress-passw0rd',
      :keystone_tenant   => 'services',
      :keystone_user     => 'congress',
      :package_ensure    => 'latest',
      :port              => '8042',
      :host              => '0.0.0.0',
    }
  end

  shared_examples_for 'congress-api' do

    context 'without required parameter keystone_password' do
      before { params.delete(:keystone_password) }
      it { expect { is_expected.to raise_error(Puppet::Error) } }
    end

    it { is_expected.to contain_class('congress::params') }
    it { is_expected.to contain_class('congress::policy') }

    it 'installs congress-api package' do
      is_expected.to contain_package('congress-api').with(
        :ensure => 'latest',
        :name   => platform_params[:api_package_name],
        :tag    => ['openstack', 'congress-package'],
      )
    end

    it 'configures keystone authentication middleware' do
      is_expected.to contain_congress_config('keystone_authtoken/admin_tenant_name').with_value( params[:keystone_tenant] )
      is_expected.to contain_congress_config('keystone_authtoken/admin_user').with_value( params[:keystone_user] )
      is_expected.to contain_congress_config('keystone_authtoken/admin_password').with_value( params[:keystone_password] )
      is_expected.to contain_congress_config('keystone_authtoken/admin_password').with_value( params[:keystone_password] ).with_secret(true)
      is_expected.to contain_congress_config('api/host').with_value( params[:host] )
      is_expected.to contain_congress_config('api/port').with_value( params[:port] )
    end

    [{:enabled => true}, {:enabled => false}].each do |param_hash|
      context "when service should be #{param_hash[:enabled] ? 'enabled' : 'disabled'}" do
        before do
          params.merge!(param_hash)
        end

        it 'configures congress-api service' do
          is_expected.to contain_service('congress-api').with(
            :ensure     => (params[:manage_service] && params[:enabled]) ? 'running' : 'stopped',
            :name       => platform_params[:api_service_name],
            :enable     => params[:enabled],
            :hasstatus  => true,
            :hasrestart => true,
            :require    => 'Class[Congress::Db]',
            :tag        => 'congress-service',
          )
        end
      end
    end

    context 'with sync_db set to true' do
      before do
        params.merge!(
          :sync_db => true)
      end
      it { is_expected.to contain_class('congress::db::sync') }
    end

    context 'with disabled service managing' do
      before do
        params.merge!({
          :manage_service => false,
          :enabled        => false })
      end

      it 'configures congress-api service' do
        is_expected.to contain_service('congress-api').with(
          :ensure     => nil,
          :name       => platform_params[:api_service_name],
          :enable     => false,
          :hasstatus  => true,
          :hasrestart => true,
          :tag        => 'congress-service',
        )
      end
    end

    context 'when running congress-api in wsgi' do
      before do
        params.merge!({ :service_name   => 'httpd' })
      end

      let :pre_condition do
        "include ::apache
         include ::congress::db
         class { 'congress': }"
      end

      it 'configures congress-api service with Apache' do
        is_expected.to contain_service('congress-api').with(
          :ensure     => 'stopped',
          :name       => platform_params[:api_service_name],
          :enable     => false,
          :tag        => 'congress-service',
        )
      end
    end

    context 'when service_name is not valid' do
      before do
        params.merge!({ :service_name   => 'foobar' })
      end

      let :pre_condition do
        "include ::apache
         include ::congress::db
         class { 'congress': }"
      end

      it_raises 'a Puppet::Error', /Invalid service_name/
    end

    context "with custom keystone identity_uri and auth_uri" do
      before do
        params.merge!({
          :keystone_identity_uri => 'https://foo.bar:35357/',
          :keystone_auth_uri => 'https://foo.bar:5000/v2.0/',
        })
      end
      it 'configures identity_uri and auth_uri but deprecates old auth settings' do
        is_expected.to contain_congress_config('keystone_authtoken/identity_uri').with_value("https://foo.bar:35357/");
        is_expected.to contain_congress_config('keystone_authtoken/auth_uri').with_value("https://foo.bar:5000/v2.0/");
      end
    end
  end

  on_supported_os({
    :supported_os   => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts({
          :fqdn           => 'some.host.tld',
          :processorcount => 2,
          :concat_basedir => '/var/lib/puppet/concat'
        }))
      end

      let(:platform_params) do
        case facts[:osfamily]
        when 'Debian'
          { :api_package_name => 'congress-api',
            :api_service_name => 'congress-api' }
        when 'RedHat'
          { :api_package_name => 'openstack-congress-api',
            :api_service_name => 'openstack-congress-api' }
        end
      end
      it_configures 'congress-api'
    end
  end

end
