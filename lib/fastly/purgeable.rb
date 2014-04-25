# Object that follows the observer pattern
# usage:
# Fastly::Purgeable.new(@article).save!
# Fastly::Purgeable.new(@article).destroy!
# This calls save on the @article and then makes a call to fastly to purge from cache
module Fastly
  class Purgeable
    # These methods need to hook into activerecord
    # Calls super
    # Purges the object from the fastly cache
    def destroy
      super
      @queue << resource_key
    end

    def destroy!
      super
      Fastly.purge(resource_key)
    end

    def save
      super
      Fastly.purge(resource_key)
    end

    def save!
      super
      Fastly.purge(resource_key)
    end

    def update
      super
      Fastly.purge(resource_key)
    end

    # updates all records in the table
    # purge table key
    def update_all
      super
      Fastly.purge(table_key)
    end
  end
end
