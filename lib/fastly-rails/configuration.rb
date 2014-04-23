module FastlyRails
  class Configuration
    MAX_AGE_DEFAULT = '2592000'

    attr_accessor :api_key, :user, :password, :max_age

    def self.max_age_default
      MAX_AGE_DEFAULT
    end

    def initialize
      @max_age = MAX_AGE_DEFAULT
    end

    def authenticatable?
      return true if api_key

      !!(user && password)
    end
  end
end
