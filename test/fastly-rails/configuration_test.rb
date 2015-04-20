require 'test_helper'

describe FastlyRails::Configuration do
  let(:configuration) { FastlyRails::Configuration.new }

  it 'should create a fastly rails client' do
    assert_instance_of FastlyRails::Configuration, configuration
  end

  it 'should have configuration attributes' do
    methods = [
      :api_key,
      :user,
      :password,
      :max_age,
      :service_id
    ]

    methods.each do |method|
      assert_respond_to configuration, method
    end
  end

  describe 'max_age_default' do
    it 'should be a class method' do
      assert_respond_to FastlyRails::Configuration, :max_age_default
    end

    it 'should return the value of a constant MAX_AGE_DEFAULT' do
      assert_equal FastlyRails::Configuration::MAX_AGE_DEFAULT, FastlyRails::Configuration.max_age_default
    end
  end

  describe 'authenticatable?' do
    before do
      configuration.api_key = nil
      configuration.user = nil
      configuration.password = nil
    end

    it 'should be an instance method' do
      assert_respond_to configuration, :authenticatable?
    end

    it 'should return false if api_key is nil' do
      assert_equal false, configuration.authenticatable?
    end

    it 'should return false if only user is not nil' do
      configuration.user = 'user'

      assert_equal false, configuration.authenticatable?
    end

    it 'should return true if only api_key is not nil' do
      configuration.api_key = 'test'
      assert_equal true, configuration.authenticatable?
    end

    it 'should return false if only user and password are not nil' do
      configuration.user      = 'user'
      configuration.password  = 'password'

      assert_equal false, configuration.authenticatable?
    end
  end

  describe 'purging_enabled?' do
    it 'is enabled by default' do
      assert_equal true, configuration.purging_enabled?
    end

    it 'is enabled when set to true' do
      configuration.purging_enabled = true
      assert_equal true, configuration.purging_enabled?
    end

    it 'is disabled when set to false' do
      configuration.purging_enabled = false
      assert_equal false, configuration.purging_enabled?
    end
  end

  it 'should have a default value for max_age since none was provided' do
    assert_equal FastlyRails::Configuration.max_age_default, configuration.max_age
  end

  describe 'invalid_service_id?' do
    it 'should return true for a nil service_id' do
      assert_nil configuration.service_id
      assert_equal true, configuration.invalid_service_id?
    end

    it 'should return true for a blank service_id' do
      configuration.service_id = ''
      assert_equal true, configuration.invalid_service_id?
    end

    it 'should return false for a non-blank, non-nil service_id' do
      configuration.service_id = 'notblank'
      assert_equal false, configuration.invalid_service_id?
    end
  end
end
