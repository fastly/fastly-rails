require 'test_helper'

describe FastlyRails::Client do

  let(:client) do
    FastlyRails::Client.new(
      :api_key => 'KEY'
    )
  end

  it 'should create a fastly rails client' do
    assert_instance_of FastlyRails::Client, client
  end

  it 'should be delegated to the fastly client' do
    assert_instance_of Fastly, client.instance_variable_get('@delegate_dc_obj')
  end

  # This is kind of a static-ish test that technically isn't necessary
  # But if we decide to lock down the methods available from the client
  # through this interface, we can ensure they're available via this test

  it 'should respond to methods available in the fastly client' do

    methods = [
      :purge,
      :get_service
    ]

    methods.each do |method|
      assert_respond_to client, method
    end

  end

  describe 'purge_by_key' do
    it 'raises if purge called and no service id configured' do
      FastlyRails.configuration.service_id = nil

      assert_raises FastlyRails::NoServiceIdProvidedError do
        client.purge_by_key('test')
      end
    end

    it 'should call Fastly::Client.post method with the purge url' do
      FastlyRails.configuration.service_id = 'testly'
      assert_equal "/service/#{FastlyRails.service_id}/purge/test", client.purge_url('test')

      resp = client.purge_by_key('test')
      assert_equal "ok", resp['status']
    end

    it 'should be authed' do
      assert_equal true, client.authed?
      assert_equal false, client.fully_authed?
    end

    describe 'when username and password are supplied' do
      before do
        client.client.user = 'USER'
        client.client.password = 'PASS'
      end

      it 'should be fully authed' do
        assert_equal true, client.authed?
        assert_equal true, client.fully_authed?
      end
    end
  end

end
