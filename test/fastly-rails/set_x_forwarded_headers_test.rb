require 'test_helper'
require 'fastly-rails/rack/set_x_forwarded_headers'

describe FastlyRails::Rack::SetXForwardedHeaders do
  let(:ip) { Faker::Internet.ip_v4_address }
  let(:middleware) { FastlyRails::Rack::SetXForwardedHeaders.new(app) }

  describe 'without fastly' do
    let(:headers) { {"HTTP_X_FORWARDED_PROTO" => "ftp"} }
    let(:app) {
      Proc.new { |env|
        assert_nil env['HTTPS'], "Env var should not exist"
        assert_equal "ftp", env['HTTP_X_FORWARDED_PROTO'], "Header should not have been modifed"
        [200, {'Content-Type' => 'text/html'}, ["hello"]]
      }
    }
    it 'should not change the env' do
      middleware.call(headers)
    end
  end

  describe 'with fastly' do
    describe 'without ssl header' do
      let(:headers) { {"HTTP_FASTLY_CLIENT_IP" => ip} }
      let(:app) {
        Proc.new { |env|
          assert_nil env['HTTPS'], "Env var should not exist"
          assert_equal "http", env['HTTP_X_FORWARDED_PROTO']
          [200, {'Content-Type' => 'text/html'}, ["hello"]]
        }
      }
      it 'should modify the env properly' do
        middleware.call(headers)
      end
    end
    describe 'with ssl header' do
      let(:headers) { {"HTTP_FASTLY_CLIENT_IP" => ip, "HTTP_FASTLY_SSL" => "1"} }
      let(:app) {
        Proc.new { |env|
          assert_equal "on", env['HTTPS']
          assert_equal "https", env['HTTP_X_FORWARDED_PROTO']
          [200, {'Content-Type' => 'text/html'}, ["hello"]]
        }
      }
      it 'should modify the env properly' do
        middleware.call(headers)
      end
    end
  end
end
