require 'fastly-rails/active_record/surrogate_key'
require 'fastly-rails/mongoid/surrogate_key'
require 'fastly-rails/action_controller/cache_control_headers'
require 'fastly-rails/action_controller/surrogate_key_headers'

module FastlyRails
  class Engine < ::Rails::Engine
    isolate_namespace FastlyRails

    config.generators do |g|
      g.test_framework      :mini_test, :spec => true, :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'test/factories'
    end

    ActiveSupport.on_load :action_controller do
      ActionController::Base.send :include, FastlyRails::CacheControlHeaders
      ActionController::Base.send :include, FastlyRails::SurrogateKeyHeaders
    end

    ActiveSupport.on_load :active_record do
      ::ActiveRecord::Base.send :include, FastlyRails::ActiveRecord::SurrogateKey
    end

    ActiveSupport.on_load :mongoid do
      ::Mongoid::Document.send :include, FastlyRails::Mongoid::SurrogateKey
    end

  end
end
