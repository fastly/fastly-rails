require 'fastly'

module FastlyRails

  ### For all intents and purposes
  ### This is a wrapper around the
  ### Fastly-ruby client

  class Client < DelegateClass(Fastly)

    def initialize(opts={})
      super(Fastly.new(opts))
    end

  end

end
