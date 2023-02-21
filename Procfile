web: bin/rails server -b 0.0.0.0 -p ${PORT:-3000}
worker: bundle exec sidekiq -e production -C config/sidekiq.yml
