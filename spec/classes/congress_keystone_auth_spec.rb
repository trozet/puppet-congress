#
# Unit tests for congress::keystone::auth
#

require 'spec_helper'

describe 'congress::keystone::auth' do

  let :facts do
    { :osfamily => 'Debian' }
  end

  describe 'with default class parameters' do
    let :params do
      { :password => 'congress_password',
        :tenant   => 'foobar' }
    end

    it { is_expected.to contain_keystone_user('congress').with(
      :ensure   => 'present',
      :password => 'congress_password',
    ) }

    it { is_expected.to contain_keystone_user_role('congress@foobar').with(
      :ensure  => 'present',
      :roles   => ['admin']
    )}

    it { is_expected.to contain_keystone_service('congress::policy').with(
      :ensure      => 'present',
      :description => 'OpenStack Policy Service'
    ) }

    it { is_expected.to contain_keystone_endpoint('RegionOne/congress::policy').with(
      :ensure       => 'present',
      :public_url   => 'http://127.0.0.1:8042',
      :admin_url    => 'http://127.0.0.1:8042',
      :internal_url => 'http://127.0.0.1:8042',
    ) }
  end

  describe 'when overriding URL parameters' do
    let :params do
      { :password     => 'congress_password',
        :public_url   => 'https://10.10.10.10:80',
        :internal_url => 'http://10.10.10.11:81',
        :admin_url    => 'http://10.10.10.12:81' }
    end

    it { is_expected.to contain_keystone_endpoint('RegionOne/congress::policy').with(
      :ensure       => 'present',
      :public_url   => 'https://10.10.10.10:80',
      :internal_url => 'http://10.10.10.11:81',
      :admin_url    => 'http://10.10.10.12:81'
    ) }
  end

  describe 'when overriding auth name' do
    let :params do
      { :password => 'foo',
        :auth_name => 'congressany' }
    end

    it { is_expected.to contain_keystone_user('congressany') }
    it { is_expected.to contain_keystone_user_role('congressany@services') }
    it { is_expected.to contain_keystone_service('congressany::policy') }
    it { is_expected.to contain_keystone_endpoint('RegionOne/congressany::policy') }
  end

  describe 'when overriding service name' do
    let :params do
      { :service_name => 'congress_service',
        :auth_name    => 'congress',
        :password     => 'congress_password' }
    end

    it { is_expected.to contain_keystone_user('congress') }
    it { is_expected.to contain_keystone_user_role('congress@services') }
    it { is_expected.to contain_keystone_service('congress_service::policy') }
    it { is_expected.to contain_keystone_endpoint('RegionOne/congress_service::policy') }
  end

  describe 'when disabling user configuration' do

    let :params do
      {
        :password       => 'congress_password',
        :configure_user => false
      }
    end

    it { is_expected.not_to contain_keystone_user('congress') }
    it { is_expected.to contain_keystone_user_role('congress@services') }
    it { is_expected.to contain_keystone_service('congress::policy').with(
      :ensure      => 'present',
      :description => 'OpenStack Policy Service'
    ) }

  end

  describe 'when disabling user and user role configuration' do

    let :params do
      {
        :password            => 'congress_password',
        :configure_user      => false,
        :configure_user_role => false
      }
    end

    it { is_expected.not_to contain_keystone_user('congress') }
    it { is_expected.not_to contain_keystone_user_role('congress@services') }
    it { is_expected.to contain_keystone_service('congress::policy').with(
      :ensure      => 'present',
      :description => 'OpenStack Policy Service'
    ) }

  end

end
