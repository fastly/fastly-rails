$:.push File.expand_path("../lib", __FILE__)

require "fastly-rails/version"

Gem::Specification.new do |s|
  s.name        = "fastly-rails"
  s.version     = FastlyRails::VERSION
  s.authors     = ["Michael May", "Hassan Shahid", "Ezekiel Templin", "Thomas O'Neil", 'Blithe Rocher']
  s.email       = ["michael@fastly.com", "hassan@fastly.com", "ezekiel@fastly.com", "tommy@fastly.com", 'blithe@fastly.com']
  s.homepage    = "https://github.com/fastly/fastly-rails"
  s.summary     = "Fastly instant purging integration for Rails"
  s.description = "Creates surrogate keys on ActiveRecord models, sets cache/surrogate headers, and adds a purge method to ActiveRecord objects."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "railties", '> 2', '< 6'
  s.add_dependency 'fastly', '~> 2.0'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "ffaker"
  s.add_development_dependency "minitest-spec-rails"
  s.add_development_dependency "appraisal"
  s.add_development_dependency 'webmock', ((RUBY_VERSION <= '1.9.3') ? '2.2.0' : '>= 2.3.0')
  s.add_development_dependency 'rails'
end
