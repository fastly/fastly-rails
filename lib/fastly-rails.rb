require "fastly-rails/engine"
require "fastly-rails/client"
require "fastly-rails/configuration"
require "fastly-rails/errors"

module FastlyRails

  attr_reader :client, :configuration

  def configuration
    @configuration ||= Configuration.new
  end

  def configure
    yield configuration if block_given?
  end

  def client
      raise NoAuthCredentialsProvidedError unless configuration.authenticatable?
      @client ||= Client.new(
        :api_key  => configuration.api_key,
        :user     => configuration.user,
        :password => configuration.password,
      )
  end

  extend self

end
