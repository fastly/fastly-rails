module FastlyRails
  module CacheControlHeaders
    extend ActiveSupport::Concern

    # Sets Cache-Control and Surrogate-Control HTTP headers
    # Surrogate-Control is stripped at the cache, Cache-Control persists (in case of other caches in front of fastly)
    # Defaults are:
    #  Cache-Control: 'public, no-cache'
    #  Surrogate-Control: 'max-age: 30 days
    # custom config example:
    #  {cache_control: 'public, no-cache, maxage=xyz', surrogate_control: 'max-age: blah'}
    def set_cache_control_headers(max_age = FastlyRails.configuration.max_age, opts = {})
      request.session_options[:skip] = true    # no cookies
      response.headers['Cache-Control'] = opts[:cache_control] || "public, no-cache"
      response.headers['Surrogate-Control'] = opts[:surrogate_control] || build_surrogate_control(max_age)
    end

    private
    def build_surrogate_control(max_age)
      surrogate_control = "max-age=#{max_age}"
      surrogate_control += ", stale-while-revalidate=#{FastlyRails.configuration.stale_while_revalidate}" if FastlyRails.configuration.stale_while_revalidate
      surrogate_control += ", stale-if-error=#{FastlyRails.configuration.stale_if_error}" if FastlyRails.configuration.stale_if_error
      surrogate_control
    end
  end
end
