require 'bundler/gem_tasks'
task default: :test

task :test do
  exec '(cd test/test_5_1/ && bin/rails db:environment:set RAILS_ENV=test && bundle exec cucumber)'
end
