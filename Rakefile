# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :test do
  Rake::TestTask.new do |t|
    t.name = "lib"
    t.pattern = "test/lib/**/*_test.rb"
    t.libs << "test"
  end
end
