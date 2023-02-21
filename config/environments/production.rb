# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Rails.application.configure do
  config.hosts << 'lead-generator-production.up.railway.app'

  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local = false

  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  config.assets.compile = false
  config.log_level = :info
  config.log_tags = %i[request_id]
  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.active_support.disallowed_deprecation = :log
  config.active_support.disallowed_deprecation_warnings = []
  config.log_formatter = Logger::Formatter.new

  if ENV['RAILS_LOG_TO_STDOUT'].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.action_controller.perform_caching = true
  config.cache_store = :redis_cache_store, {
    namespace: ENV.fetch('APP_NAME', nil),
    redis: lambda {
      Redis.new(
        host: ENV.fetch('REDIS_HOST', nil),
        port: ENV.fetch('REDIS_PORT', nil),
        db: ENV.fetch('REDIS_DB', nil),
        password: ENV.fetch('REDIS_PASSWORD', nil).presence
      )
    }
  }
end
