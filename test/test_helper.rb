# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require "minitest/autorun"
require 'database_cleaner'
require 'ffaker'
require 'factory_girl_rails'
require 'webmock/minitest'

Rails.backtrace_cleaner.remove_silencers!

#include factories
Dir["#{File.dirname(__FILE__)}/dummy/test/factories/*.rb"].each { |f| require f }
# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
# if ActiveSupport::TestCase.method_defined?(:fixture_path=)
#   ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
#   ActiveSupport::TestCase.fixtures :all
# end

ActiveRecord::Migrator.migrate File.expand_path('../dummy/db/migrate/', __FILE__)

class Minitest::Spec
  include FactoryGirl::Syntax::Methods

  before :each do
    stub_request(:any, "https://api.fastly.com/login").
      to_return(
        :status   => 200,
        :body     => "{}"
    )
    stub_request(:post, /https:\/\/api.fastly.com\/service\/.*\/purge\/.*/)
    .to_return(
      body: "{\"status\":\"ok\"}"
    )

    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end

end

class ActionController::TestCase
  include FactoryGirl::Syntax::Methods
end

class ActionDispatch::IntegrationTest
  include FactoryGirl::Syntax::Methods

  def setup
    stub_request(:any, /.*/).
    to_return(
        :status   => 200,
        :body     => "{}"
    )

  end

end
