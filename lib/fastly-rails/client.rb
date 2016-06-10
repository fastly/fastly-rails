require 'fastly'
require 'uri'

module FastlyRails
  # A simple wrapper around the fastly-ruby client.
  class Client < DelegateClass(Fastly)
    def initialize(opts={})
      super(Fastly.new(opts))
    end

    def purge_by_key(*args)
      Fastly::Service.new({id: FastlyRails.service_id}, FastlyRails.client).purge_by_key(*args)
    end

    def purge_url(key)
      "/service/#{FastlyRails.service_id}/purge/#{URI.escape(key)}"
    end
  end
end
