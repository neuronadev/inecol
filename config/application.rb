require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Inecol
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    #config.active_storage.replace_on_assign_to_many = false
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    #config.time_zone = :local
    config.time_zone = "Mexico City"
    config.active_record.default_timezone = :local
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
     config.active_storage.replace_on_assign_to_many = false
     config.after_initialize do
          ActionText::ContentHelper.allowed_attributes.add 'style'
          ActionText::ContentHelper.allowed_attributes.add 'controls'
          ActionText::ContentHelper.allowed_attributes.add 'poster'
          ActionText::ContentHelper.allowed_attributes.add 'centered-div'
     end     
  end
end
