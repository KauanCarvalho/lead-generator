# frozen_string_literal: true

sidekiq_default_options = {
  port: ENV.fetch('REDIS_PORT', nil),
  db: ENV.fetch('REDIS_DB', nil),
  host: ENV.fetch('REDIS_HOST', nil),
  network_timeout: 5,
  pool_timeout: 5
}

Sidekiq.configure_server do |config|
  config.redis = sidekiq_default_options.merge(size: 20)
  schedule_file = 'config/sidekiq_cron.yml'

  Rails.application.reloader.to_prepare do
    Sidekiq::Cron::Job.load_from_hash(YAML.load_file(schedule_file)) if File.exist?(schedule_file)
  end
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_default_options.merge(size: 5)
end
