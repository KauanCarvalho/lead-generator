# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

# Configure Sidekiq-specific session middleware.
# Soon we will auth with device.
Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: '_interslice_session'

mount Sidekiq::Web => '/sidekiq'
