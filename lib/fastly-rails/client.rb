require 'fastly'

module FastlyRails
  # A simple wrapper around the fastly-ruby client.
  class Client < DelegateClass(Fastly)
    def initialize(opts={})
      super(Fastly.new(opts))
    end

    def purge_by_key(key)
      client.require_key!
      url = purge_url(key)
      client.post(url).tap do
        if callback = FastlyRails.configuration.after_purge
          callback.call(key, url)
        end
      end
    end

    def purge_url(key)
      "/service/#{FastlyRails.service_id}/purge/#{key}"
    end
  end
end
