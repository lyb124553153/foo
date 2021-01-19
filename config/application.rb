require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Foo
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    if Rails.env.development?
      Rails.application.routes.default_url_options[:host] = 'localhost:3000'
    else
      Rails.application.routes.default_url_options[:host] = 'protected-citadel-14400.herokuapp.com'
    end
  end
end
