# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
# Settings in config/environments/* take precedence over those specified here.
# Application configuration can go into files in config/initializers
# -- all .rb files in that directory are automatically loaded after loading
# the framework and any gems in your application.
Bundler.require(*Rails.groups)

module EthuGamedbApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.eager_load_paths << Rails.root.join('lib')

    config.i18n.load_path += Dir["#{Rails.root}/plugins/*/config/locales/*.yml"]
    config.active_job.queue_adapter = :sidekiq
  end
end

# TODO: - Use these code snippet from the pro
# # Configure sensitive parameters which will be filtered from the log file.
#     config.filter_parameters += [
#       :password,
#       :pop3_polling_password,
#       :api_key,
#       :s3_secret_access_key,
#       :twitter_consumer_secret,
#       :facebook_app_secret,
#       :github_client_secret,
#       :second_factor_token,
#     ]
