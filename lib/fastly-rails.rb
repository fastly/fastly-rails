require "fastly-rails/engine"
require "fastly-rails/client"
require "fastly-rails/configuration"
require "fastly-rails/errors"

module FastlyRails

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration if block_given?
  end

  def self.service_id
    raise NoServiceIdProvidedError if configuration.invalid_service_id?
    configuration.service_id
  end

  def self.purging_enabled?
    configuration.purging_enabled?
  end

  def self.purge_by_key(*args)
    client.purge_by_key(*args) if purging_enabled?
  end

  def self.client
    raise NoAPIKeyProvidedError unless configuration.authenticatable?

    @client ||= Client.new(
      :api_key  => configuration.api_key,
      :user     => configuration.user,
      :password => configuration.password,
    )
  end

end
