require 'test_helper'

describe FastlyRails::Client do

  let(:client) do
    FastlyRails::Client.new(
      :api_key => 'KEY', :user => 'USER', :password => 'PASS'
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

end
