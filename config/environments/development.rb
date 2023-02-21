# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Rails.application.configure do
  config.hosts << 'lead-generator-production.up.railway.app'

  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true

  if ENV.fetch('REDIS_HOST', nil).presence
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
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.active_support.deprecation = :log
  config.active_support.disallowed_deprecation = :raise
  config.active_support.disallowed_deprecation_warnings = []
  config.assets.debug = true
  config.assets.quiet = true

  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
