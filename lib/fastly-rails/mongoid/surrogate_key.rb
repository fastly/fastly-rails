# Adds surrogate key methods to ActiveRecord models
module FastlyRails
  module Mongoid
    module SurrogateKey
      extend ActiveSupport::Concern

      module ClassMethods

        def purge_all
          FastlyRails.client.get_service(service_id).purge_by_key(table_key)
        end

        def table_key
          collection_name
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
        FastlyRails.client.get_service(service_id).purge_by_key(record_key)
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
