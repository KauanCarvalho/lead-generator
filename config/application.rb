# frozen_string_literal: true

require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'sprockets/railtie'
require 'rails/test_unit/railtie'

Bundler.require(*Rails.groups)

module LeadGenerator
  class Application < Rails::Application
    config.load_defaults 6.1

    config.i18n.default_locale = :'pt-BR'
    config.i18n.fallbacks = %i[en]
    config.time_zone = 'Brasilia'

    extra_paths = [Rails.root.join('lib'), Rails.root.join('app/services')]
    config.autoload_paths.concat(extra_paths)
    config.eager_load_paths.concat(extra_paths)
  end
end
