# adds surrogate key instance methods to the models that inherit from activerecord
module FastlyRails
  module SurrogateKey
    extend ActiveSupport::Concern

    included do
      include InstanceMethods
    end

    module ClassMethods

      def purge_all
        FastlyRails.client.purge(table_key)
      end

      def table_key
        table_name
      end

    end

    module InstanceMethods

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
