module FastlyRails
  module SurrogateControlHeaders
    # Sets Surrogate-Control header
    # Defaults are:
    #  Cache-Control: 'public, no-cache, s-maxage: 30 days'
    #  Surrogate-Control: 'max-age: 30 days
    # custom config example:
    #  {cache_control: 'blah, blah, blah', surrogate_control: 'max-age: blah'}
    def set_surrogate_key_header(*surrogate_keys)
      request.session_options[:skip] = true    # no cookies
      response.headers['Surrogate-Key'] = surrogate_keys.join(' ')
    end
  end
end
