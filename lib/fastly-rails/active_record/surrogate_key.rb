# Adds surrogate key methods to ActiveRecord models
# Purge methods use a POST over PURGE
# The choice of this HTTP method should not effect anything
module FastlyRails
  module ActiveRecord
    module SurrogateKey
      extend ActiveSupport::Concern

      module ClassMethods

        def purge_all
          FastlyRails.client.purge_by_key(table_key)
        end

        def table_key
          table_name
        end

        def service_id
          FastlyRails.service_id
        end
      end

      def record_key
        "#{table_key}/#{id}"
      end

      def table_key
        self.class.table_key
      end

      def purge
        FastlyRails.client.purge_by_key(record_key)
      end

      def purge_all
        self.class.purge_all
      end

      def service_id
        self.class.service_id
      end
    end
  end
end
