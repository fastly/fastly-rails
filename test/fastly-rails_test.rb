require 'test_helper'

describe FastlyRails do
  let(:api_key)       { 'test' }
  let(:user)          { nil }
  let(:password)      { nil }
  let(:max_age)       { 100000 }
  let(:configuration) { FastlyRails.configuration }
  let(:service_id)    { 'someserviceid' }
  let(:client)        { FastlyRails.client }

  it 'should be a module' do
    assert_kind_of Module, FastlyRails
  end

  describe 'credentials not provided' do
    before do
      FastlyRails.instance_variable_set('@configuration', FastlyRails::Configuration.new)
    end

    it 'should raise an error if configuration is not authenticatable' do
      assert_equal false, configuration.authenticatable?
      assert_equal true, configuration.invalid_service_id?
      assert_raises FastlyRails::NoAPIKeyProvidedError do
        client
      end
      assert_raises FastlyRails::NoServiceIdProvidedError do
        FastlyRails.service_id
      end
    end
  end

  describe 'credentials provided' do
    before do
      FastlyRails.configure do |c|
        c.api_key   = api_key
        c.user      = user
        c.password  = password
        c.max_age   = max_age
        c.service_id = service_id
      end
    end

    it 'should have configuration options set up' do
      assert_equal api_key, configuration.api_key
      assert_equal user, configuration.user
      assert_equal password, configuration.password
      assert_equal max_age, configuration.max_age
      assert_equal service_id, configuration.service_id
    end

    it 'should return a valid client' do
      assert_instance_of FastlyRails::Client, client
    end
  end
end
