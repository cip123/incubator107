require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Incubator107
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ro
    config.i18n.fallbacks = true
    config.i18n.fallbacks = [:ro]
    I18n.reload!
    
    config.autoload_paths += %W(#{config.root}/lib)
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    

    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif, *.ttf) 
    #Rails.application.routes.default_url_options[:host] = '???'

    config.assets.precompile += %w[active_admin.css active_admin.js print.css]
    config.assets.precompile += %w[active_admin/print.css]
    

    #assets.precompile += %w(*.png *.jpg *.jpeg *.gif)   
    config.hosts = {
      "development" => "lvh.me:3000",
      "test"        => "lvh.me:3001",
      "production"  => "stage.incubator107.com"
    }
  end
end
