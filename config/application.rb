require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module Studenthub
    class Application < Rails::Application
        config.time_zone = 'Pretoria'

        # Compile our template assets.
        config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
        config.assets.paths << Rails.root.join('vendor', 'assets', 'images')
        config.assets.precompile += %w(*.woff *.eot *.svg *.ttf)
    end
end
