module FastlyRails

  class Configuration

    attr_reader :api_key, :user, :password, :max_age

    MAX_AGE_DEFAULT = '2592000'

    class << self

      def max_age_default
        MAX_AGE_DEFAULT
      end

    end

    def initialize
      @api_key   = nil
      @user      = nil
      @password  = nil
      @max_age   = self.class.max_age_default
    end

    def api_key=(val)
      @api_key = val
    end

    def user=(val)
      @user = val
    end

    def password=(val)
      @password = val
    end

    def max_age=(val)
      @max_age = val
    end

    def authenticatable?
      !api_key.nil? || (!user.nil? && !password.nil?)
    end

  end

end

