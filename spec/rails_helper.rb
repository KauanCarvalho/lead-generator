# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

require 'spec_helper'

require File.expand_path('../config/environment', __dir__)

require 'rspec/rails'
require 'shoulda/matchers'

abort('The Rails environment is running in production mode!') if Rails.env.production?

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.use_active_record = false
  config.fixture_path = Rails.root.join('/spec/fixtures')
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.order = 'random'
  config.example_status_persistence_file_path = Rails.root.join('/tmp/examples.txt')

  # Custom 'support' files.
  FactoryBotConfig.configure(config)
  ShouldaMatchersConfig.configure
end
