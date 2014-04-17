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
      :max_age
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

    it 'should return false if api_key, user, and password are nil' do
      assert_equal false, configuration.authenticatable?
    end

    it 'should return false if only user is not nil' do

      configuration.user = 'user'

      assert_equal false, configuration.authenticatable?

    end

    it 'should return true if only api_key is not nil' do

      configuration.api_key = 'key'

      assert_equal true, configuration.authenticatable?

    end

    it 'should return true if if user and password are not nil' do

      configuration.user      = 'user'
      configuration.password  = 'password'

      assert_equal true, configuration.authenticatable?

    end
  end

  it 'should have a default value for max_age since none was provided' do
    assert_equal FastlyRails::Configuration.max_age_default, configuration.max_age
  end

end
