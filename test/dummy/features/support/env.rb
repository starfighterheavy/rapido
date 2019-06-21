require 'cucumber/rails'
require 'rspec/matchers'
require 'cucumber/api_steps'
require 'cucumber/sammies/step_definitions/content_steps'
require 'cucumber/sammies/step_definitions/navigation_steps'
require 'cucumber/sammies/step_definitions/form_steps'
require 'cucumber/sammies/step_definitions/troubleshooting_steps'
require 'cucumber/persona/step_definitions/persona_steps'

ActionController::Base.allow_rescue = false

begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise 'You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it.'
end

Cucumber::Rails::Database.javascript_strategy = :truncation
