module FastlyRails
  module SurrogateKeyHeaders
    # Sets Surrogate-Key header with the provided surrogate key
    def set_surrogate_key_header(surrogate_key)
      request.session_options[:skip] = true    # no cookies
      response.headers['Surrogate-Key'] = surrogate_key
    end

  end
end
