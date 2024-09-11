# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"


# all_tests.rake
require 'rspec/core/rake_task'

# Define the "spec" task, at task load time rather than inside another task
RSpec::Core::RakeTask.new(:spec)

desc 'Run all tests, even those usually excluded.'
task all_tests: :environment do
  ENV['RUN_ALL_TESTS'] = 'true'
  Rake::Task['spec'].invoke
end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new # defines a task named cucumber​

require 'coveralls/rake/task'
Coveralls::RakeTask.new
task test_with_coveralls: [ :spec, :features, 'coveralls:push' ]

Rails.application.load_tasks
