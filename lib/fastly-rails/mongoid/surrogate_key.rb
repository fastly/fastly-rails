# Adds surrogate key methods to ActiveRecord models
module FastlyRails
  module Mongoid
    module SurrogateKey
      extend ActiveSupport::Concern

      module ClassMethods

        def purge_all
          FastlyRails.client.purge(table_key)
        end

        def table_key
          collection_name
        end

      end

      def record_key
        "#{table_key}/#{id}"
      end

      def table_key
        self.class.table_key
      end

      def purge
        FastlyRails.client.purge(record_key)
      end

      def purge_all
        self.class.purge_all
      end

    end
  end
end
