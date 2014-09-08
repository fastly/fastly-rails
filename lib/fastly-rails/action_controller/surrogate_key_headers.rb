module FastlyRails
  module SurrogateKeyHeaders

    # Sets Surrogate-Key HTTP header with one or more keys
    # strips session data from the request
    def set_surrogate_key_header(*surrogate_keys)
      request.session_options[:skip] = true  # No Set-Cookie
      response.headers['Surrogate-Key'] = surrogate_keys.join(' ')
    end
  end
end
