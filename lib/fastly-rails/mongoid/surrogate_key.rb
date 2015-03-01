# Adds surrogate key methods to ActiveRecord models
module FastlyRails
  module Mongoid
    module SurrogateKey
      extend ActiveSupport::Concern

      module ClassMethods

        def purge_all
          FastlyRails.purge_by_key(table_key)
        end

        def table_key
          collection_name
        end

        def fastly_service_identifier
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
        FastlyRails.purge_by_key(record_key)
      end

      def purge_all
        self.class.purge_all
      end

      def fastly_service_identifier
        self.class.fastly_service_identifier
      end

    end
  end
end
