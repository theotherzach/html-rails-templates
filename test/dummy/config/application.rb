require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "rails/test_unit/railtie"
begin
  require 'sprockets/rails'
rescue Exception
  require "sprockets/railtie"
end

Bundler.require(*Rails.groups)
require "angular-rails-templates"

module Dummy
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    config.assets.enabled = true
    config.assets.version = "#{Time.now}" # always expire cached assets on Rails Boot

    config.html_js_templates.ignore_prefix = 'ignored_namespace/'
  end
end
