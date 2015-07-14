require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Inklings
    class Application < Rails::Application
        config.autoload_paths += %W( #{ config.root }/lib )
        
        # do not include all view helpers in every controller. instead, only include
        # the application helper and the controller's specific helper.
        config.action_controller.include_all_helpers = false
        
        # override the default behavior for input fields that fail validation (that is,
        # wrapping the field with the error in a new div with the class "field-with-error").
        # instead, just add the class "field-error" to the offending field.
        config.action_view.field_error_proc = Proc.new do | html_tag, instance |
            class_attr_index = html_tag.index 'class="'
            
            if class_attr_index
                html_tag.insert class_attr_index + 7, 'field-error '
            else
                html_tag.insert html_tag.index( '>' ), ' class="field-error"'
            end
        end
        # Settings in config/environments/* take precedence over those specified here.
        # Application configuration should go into files in config/initializers
        # -- all .rb files in that directory are automatically loaded.

        # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
        # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
        # config.time_zone = 'Central Time (US & Canada)'

        # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
        # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
        # config.i18n.default_locale = :de
    end
end
