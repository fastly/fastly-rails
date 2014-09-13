describe FastlyRails::Rack::RemoveSetCookieHeader do
  it "removes 'set-cookie' header if 'surrogate-control' header present" do
    headers = { "Surrogate-Control" => "test", "Set-Cookie" => "NOOO" }

    app = Rack::Builder.new do
      use FastlyRails::Rack::RemoveSetCookieHeader
      run lambda { |env| Rack::Response.new("", 200, headers).finish }
    end

    env = Rack::MockRequest.env_for('/')
    response = Rack::MockResponse.new(*app.call(env))

    assert_nil response.headers['Set-Cookie']
  end

  it "removes 'set-cookie' header if 'surrogate-key' header present" do
    headers = { "Surrogate-Key" => "test", "Set-Cookie" => "NOOO" }

    app = Rack::Builder.new do
      use FastlyRails::Rack::RemoveSetCookieHeader
      run lambda { |env| Rack::Response.new("", 200, headers).finish }
    end

    env = Rack::MockRequest.env_for('/')
    response = Rack::MockResponse.new(*app.call(env))

    assert_nil response.headers['Set-Cookie']
  end

  it "keeps 'set-cookie' if no 'surrogate-control' or 'surrogate-key'" do
    headers = { "Set-Cookie" => "yes!!" }

    app = Rack::Builder.new do
      use FastlyRails::Rack::RemoveSetCookieHeader
      run lambda { |env| Rack::Response.new("", 200, headers).finish }
    end

    env = Rack::MockRequest.env_for('/')
    response = Rack::MockResponse.new(*app.call(env))

    assert_equal response.headers['Set-Cookie'], "yes!!"
  end
end
