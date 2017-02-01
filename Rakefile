begin
  require 'rubygems'
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'FastlyRails'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

APP_RAKEFILE = File.expand_path("../test/dummy/Rakefile", __FILE__)

Bundler::GemHelper.install_tasks

namespace :test do
  desc 'Install dependencies for all tests with appraisal'
  task :setup do
    sh 'bin/rails db:environment:set RAILS_ENV=test 2>&1 >/dev/null || exit 0'
    sh 'appraisal install'
  end

  desc 'Run all tests with appraisal'
  task :all do
    sh 'appraisal rake test'
  end
end

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end


task default: :test
