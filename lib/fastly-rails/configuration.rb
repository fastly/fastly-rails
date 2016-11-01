module FastlyRails
  class Configuration
    # 30 days
    MAX_AGE_DEFAULT = '2592000'

    attr_accessor :api_key, :user, :password, :max_age, :service_id, :stale_while_revalidate, :stale_if_error
    attr_writer :purging_enabled

    def self.max_age_default
      MAX_AGE_DEFAULT
    end

    def initialize
      @max_age = MAX_AGE_DEFAULT
      @purging_enabled = true
    end

    def authenticatable?
      !!api_key
    end

    def invalid_service_id?
      service_id_nil? || service_id_blank?
    end

    def purging_enabled?
      @purging_enabled
    end

    private

    def has_credentials?
      user && password
    end

    def service_id_nil?
      service_id.nil?
    end

    def service_id_blank?
      service_id.blank?
    end
  end
end
