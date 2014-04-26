module FastlyRails
  class Configuration
    # 30 days
    MAX_AGE_DEFAULT = '2592000'

    attr_accessor :api_key, :user, :password, :max_age

    def self.max_age_default
      MAX_AGE_DEFAULT
    end

    def initialize
      @max_age = MAX_AGE_DEFAULT
    end

    def authenticatable?
      !!(api_key || has_credentials?)
    end

    private

    def has_credentials?
      user && password
    end
  end
end
