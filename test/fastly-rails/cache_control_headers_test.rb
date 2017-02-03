require_relative '../test_helper'

describe 'FastlyRails::CacheControlHeaders' do
  let(:controller) do
    Class.new do
      include FastlyRails::CacheControlHeaders

      attr_reader :request, :response

      def initialize
        @request = Struct.new(:session_options).new({})
        @response = Struct.new(:headers).new({})
      end
    end.new
  end

  before { FastlyRails.configure { |c| c.max_age = 2592000 } }

  it 'sets max_age' do
    controller.set_cache_control_headers(16)

    expected = {"Cache-Control"=>"public, no-cache", "Surrogate-Control"=>"max-age=16"}
    actual = controller.response.headers

    assert_equal expected, actual
  end

  it 'sets stale_while_revalidate' do
    controller.set_cache_control_headers(FastlyRails.configuration.max_age, stale_while_revalidate: 32)

    expected = {"Cache-Control"=>"public, no-cache", "Surrogate-Control"=>"max-age=2592000, stale-while-revalidate=32"}
    actual = controller.response.headers

    assert_equal expected, actual
  end

  it 'sets stale_if_error' do
    controller.set_cache_control_headers(FastlyRails.configuration.max_age, stale_if_error: 64)

    expected = {"Cache-Control"=>"public, no-cache", "Surrogate-Control"=>"max-age=2592000, stale-if-error=64"}
    actual = controller.response.headers

    assert_equal expected, actual
  end
end
