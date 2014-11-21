require 'fastly'

module FastlyRails
  # A simple wrapper around the fastly-ruby client.
  class Client < DelegateClass(Fastly)
    def initialize(opts={})
      super(Fastly.new(opts))
    end

    def purge_by_key(key)
      unless ENV["FASTLY_CACHE_DISABLED"].present?
        client.require_key!
        client.post purge_url(key)
      end
    end

    def purge_url(key)
      "/service/#{FastlyRails.service_id}/purge/#{key}"
    end
  end
end
