# frozen_string_literal: true

require_relative 'boot'

require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
# require 'sprockets/railtie'
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module HexletCv
  class Application < Rails::Application
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

    config.action_dispatch.rescue_responses['Pundit::NotAuthorizedError'] = :forbidden

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.exceptions_app = routes

    # https://docs.rubocop.org/rubocop-rails/cops_rails.html#railsenvironmentvariableaccess
    config.vars = {
      ga: ENV.fetch('GOOGLE_ANALYTICS_KEY', nil),
      gtm: ENV.fetch('GOOGLE_TAG_MANAGER_KEY', nil),
      email_from: ENV.fetch('EMAIL_FROM', nil)
    }

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.i18n.default_locale = :ru
    config.generators do |g|
      g.assets false
    end

    config.active_record.yaml_column_permitted_classes = [
      ActiveSupport::HashWithIndifferentAccess
    ]
  end
end
