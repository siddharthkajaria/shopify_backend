require_relative "boot"

require "rails/all"
require "active_storage/engine"


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CampaignMailer
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.serve_static_assets = true

    # Store files locally.
    config.active_storage.service = :local

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.autoloader = :classic
    
    # here we are overwriding the Devise Layout to admin.html.erb
    config.to_prepare do
      Devise::SessionsController.layout "admin_login"
      Devise::RegistrationsController.layout proc{ |controller| user_signed_in? ? "admin_login" : "admin_login" }
      Devise::ConfirmationsController.layout "admin_login"
      Devise::UnlocksController.layout "admin_login"            
      Devise::PasswordsController.layout "admin_login"
    end

  end
end
